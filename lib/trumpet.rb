$:.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'resourceful'
require 'json'

require 'core_extensions'


module Trumpet
end

require 'trumpet/request'
require 'trumpet/trumpet_resource'
require 'trumpet/exceptions'
require 'trumpet/message'
require 'trumpet/receiver'
require 'trumpet/listener'
require 'trumpet/transmitter'
require 'trumpet/channel'
require 'trumpet/helpers'