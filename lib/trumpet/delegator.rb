# This module defines the delegate_with_credentials method on classes that include it
# This allows the class to say the following :
#
#   delegate_with_request :users, Trumpet::User
# 
# And any instance of the class will have a users method on it, which will delegate
# calls to the Trumpet::User class with the proper request object in the args

module Trumpet
  module Delegator
    
    class ResourceDelegator
      def initialize(delegate, credentials)
        @delegate = delegate
        @credentials = credentials
      end

      def method_missing(sym, args=nil)
        if args.nil?
          new_args = Hash.new
          new_args[:credentials] = @credentials if @credentials
          @delegate.send sym, new_args
        elsif args.is_a? Hash
          new_args = {}
          new_args[:parameters] = args
          new_args[:credentials] = @credentials if @credentials
          @delegate.send sym, new_args
        else
          new_args = [args]
          new_args << {:credentials => @credentials} if @credentials            
          @delegate.send sym, *new_args
        end
      end
    end
    
    def self.included(includer)
      class << includer
        def delegate_with_credentials(resource, klass)
          define_method resource do
            ResourceDelegator.new(klass, @credentials)
          end
        end
      end
    end
    
  end
end