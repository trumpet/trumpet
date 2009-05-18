module Trumpet
  class Resource
    
    def to_h(excludes=[])
      excludes << '@credentials'
      instance_variables.inject({}) do |hash, value|
        hash[value.gsub('@', '')] = instance_variable_get(value) unless excludes.include?(value)
        hash
      end
    end
    
    protected
    
      def initialize(attributes)
        attributes.each do |attribute, value|
          self.class.send(:define_method, attribute) { instance_variable_get(:"@#{attribute.to_s}") }
          instance_variable_set(:"@#{attribute.to_s}", value)
        end
      end
      
    private
    
      def set_attributes(attributes)
        attributes.each do |attribute, value|
          instance_variable_set(:"@#{attribute.to_s}", value)
        end
      end
  end
end
