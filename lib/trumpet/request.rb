module Trumpet
  module Request
    @@http = Resourceful::HttpAccessor.new
    @@uri = 'http://api.trumpet.io:3000'
  
    def self.authenticate(username, password)
      my_realm_authenticator = Resourceful::BasicAuthenticator.new('Trumpet', username, password)    
      @@http = Resourceful::HttpAccessor.new(:authenticator => my_realm_authenticator)
    end
  
    def self.get(path, options={})
      do_request(:get, path, options)
    end

    def self.post(path, options={})
      do_request(:post, path, options)
    end

    def self.put(path, options={})
      do_request(:put, path, options)
    end

    def self.delete(path, options={})
      do_request(:delete, path, options) 
    end
    
    def self.set_server(uri)
      @@uri = uri
    end

    private
  
      def self.do_request(method, path, options)
        resource = @@http.resource("#{@@uri}#{URI.encode(path)}")
        begin
          response =
            if method == :post
              resource.send(method, options[:parameters].to_params, :content_type => "application/x-www-form-urlencoded")
            elsif options[:parameters]
              resource.send(method, options[:parameters].to_params)
            else
              resource.send(method)
          end
        rescue Resourceful::UnsuccessfulHttpRequestError => e
          response = e.http_response
          error_string = JSON.parse(response.body).to_s
        
          case response.code
          when 400
            raise Trumpet::BadRequest, error_string
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
        rescue IOError # Coudln't connect to server
          raise Trumpet::ServerConnectionError, 'Could not connect to server'
        end
      
        (options[:parse_response] == false) ? response : JSON.parse(response.body)
      end
  end
end
