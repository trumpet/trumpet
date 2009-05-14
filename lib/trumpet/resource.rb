module Trumpet
  class Resource
    
    protected
    
      def initialize(attributes)
        attributes.each do |attribute, value|
          self.class.send(:define_method, attribute) { instance_variable_get(:"@#{attribute.to_s}") }
          instance_variable_set(:"@#{attribute.to_s}", value)
        end
      end
  end
end
