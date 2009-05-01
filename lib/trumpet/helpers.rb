module Trumpet
  def self.authenticate_with(username, password)
    Trumpet::Request.authenticate(username, password)
  end
end