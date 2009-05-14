module Trumpet  
  def self.set_server(uri, port=nil)
    Trumpet::Request.set_server(uri, port)
  end
end