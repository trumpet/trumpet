$:.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'resourceful'
require 'json'

require 'core_extensions'
require 'http'


module Trumpet
  include HTTP
  
  def authenticate(name, token)
    
  end
  
  def authenticated?
    
  end
end

require 'trumpet/trumpet_resource'
require 'trumpet/exceptions'
require 'trumpet/message'
require 'trumpet/receiver'
require 'trumpet/listener'
require 'trumpet/transmitter'
require 'trumpet/channel'