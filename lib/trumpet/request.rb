module Trumpet
  module Request
    @@http = Net::HTTP.new('api.trumpet.io', 3000)
    @@http_auth = {}
  
    def self.authenticate(username, password)
      @@http_auth[:username] = username
      @@http_auth[:password] = password
    end
    
    def self.clear_credentials
      @@http_auth = {}
    end
      
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
    
    def self.set_server(uri, port=nil)
      @@http = Net::HTTP.new(uri.gsub('http://', ''), port) #no http:// in hosts
    end

    private
  
      def self.do_request(http_method, path, options)
        raw_request = http_method.new(path)
        raw_request.basic_auth(@@http_auth[:username], @@http_auth[:password]) unless @@http_auth.empty?
        raw_request.body = options[:parameters].to_params if options[:parameters]


        response = @@http.request(raw_request)

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
          when 500
            raise Trumpet::InternalServerError, error_string
          when 501
            raise Trumpet::NotImplemented, error_string
          end
        end      
        (options[:parse_response] == false) ? response : JSON.parse(response.body)
      end
  end
end
