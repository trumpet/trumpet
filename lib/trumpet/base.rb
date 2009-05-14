module Trumpet
  class Base
    include Delegator
    
    delegate_with_credentials :users,         User
    delegate_with_credentials :channels,      Channel
    delegate_with_credentials :messages,      Message
    delegate_with_credentials :receivers,     Receiver
    delegate_with_credentials :listeners,     Listener
    delegate_with_credentials :transmitters,  Transmitter
            
    def initialize(credentials={})
      @credentials = credentials unless credentials.empty?
    end
  end
end