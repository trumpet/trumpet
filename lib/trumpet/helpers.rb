module Trumpet
  def self.authenticate(username, password)
    Trumpet::Request.authenticate(username, password)
    true
  end
  
  def self.set_server(uri, port=nil)
    Trumpet::Request.set_server(uri, port)
  end
end