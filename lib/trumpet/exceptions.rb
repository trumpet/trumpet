# TODO: Add more exceptions here

module Trumpet
  
  # A generic exception to use until we have more specific exceptions
  # for everything
  class TrumpetError < StandardError; end
  
  # Exception raised when the connection to the server fails
  class ServerConnectionError < TrumpetError; end
  
  # HTTP 400 Error
  class BadRequest < TrumpetError; end
  
  # HTTP 401 Error
  class Unauthorized < TrumpetError; end
  
  # HTTP 403 Error
  class Forbidden < TrumpetError; end
  
  # HTTP 404 Error
  class NotFound  < TrumpetError; end
  
  # HTTP 405 Error
  class MethodNotAllowed  < TrumpetError; end
  
  # HTTP 409 Error
  class Conflict < TrumpetError; end
  
  # HTTP 500 Error
  class InternalServerError  < TrumpetError; end
  
  # HTTP 501 Error
  class NotImplemented  < TrumpetError; end
end