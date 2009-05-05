# TODO: Add more exceptions here

module Trumpet
  
  # Exception raised when the connection to the server fails
  class ServerConnectionError < StandardError; end
  
  # A generic exception to use until we have more specific exceptions
  # for everything
  class TrumpetError < StandardError; end
  
  # HTTP 400 Error
  class BadRequest < StandardError; end
  
  # HTTP 401 Error
  class Unauthorized < StandardError; end
  
  # HTTP 403 Error
  class Forbidden < StandardError; end
  
  # HTTP 404 Error
  class NotFound  < StandardError; end
  
  # HTTP 405 Error
  class MethodNotAllowed  < StandardError; end
  
  # HTTP 500 Error
  class InternalServerError  < StandardError; end
  
  # HTTP 501 Error
  class NotImplemented  < StandardError; end
end