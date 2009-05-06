$:.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'json'

require 'net/http'
require 'uri'

require 'core_extensions'


module Trumpet
end

require 'trumpet/request'
require 'trumpet/exceptions'
require 'trumpet/message'
require 'trumpet/receiver'
require 'trumpet/listener'
require 'trumpet/transmitter'
require 'trumpet/channel'
require 'trumpet/user'
require 'trumpet/helpers'