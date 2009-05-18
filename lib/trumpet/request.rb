module Trumpet
  module Request
    @@http = Net::HTTP.new('api.trumpet.io')
     
    def self.get(path, options={})
      do_request(Net::HTTP::Get, path, options)
    end

    def self.post(path, options={})
      do_request(Net::HTTP::Post, path, options)
    end

    def self.put(path, options={})
      do_request(Net::HTTP::Put, path, options)
    end

    def self.delete(path, options={})
      do_request(Net::HTTP::Delete, path, options)
    end
    
    def self.set_server(host, port=nil)
      @@http = Net::HTTP.new(host.gsub('http://', ''), port) #no http:// in hosts
    end

    private
  
      def self.do_request(http_method, path, options={})
        raw_request = http_method.new(path)
        raw_request.basic_auth(options[:credentials][:username], options[:credentials][:password]) if options[:credentials]
        raw_request.body = options[:parameters].to_params if options[:parameters]
        
        response = @@http.request(raw_request)
        handle_errors(response)
        
        if options[:parse_response] == false
          response 
        else
          parsed_response = JSON.parse(response.body)
          attach_credentials(parsed_response, options[:credentials]) if options[:credentials]
          parsed_response
        end
      end
      
      def self.handle_errors(response)
        unless response.code.to_i < 400
          error_string = JSON.parse(response.body).to_s
          case response.code.to_i
          when 400
            raise Trumpet::BadRequest, error_string
          when 401
            raise Trumpet::Unauthorized, error_string
          when 403
            raise Trumpet::Forbidden, error_string
          when 404
            raise Trumpet::NotFound, error_string
          when 405
            raise Trumpet::MethodNotAllowed, error_string
          when 409
            raise Trumpet::Conflict, error_string
          when 500
            raise Trumpet::InternalServerError, error_string
          when 501
            raise Trumpet::NotImplemented, error_string
          end
        end
      end
      
      def self.attach_credentials(parsed_response, credentials)
        if parsed_response.is_a? Array
          parsed_response.each do |attributes|
            attributes[:credentials] = credentials
          end
        else
          parsed_response[:credentials] = credentials
        end
      end
      
  end
end
