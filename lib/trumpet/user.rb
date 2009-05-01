module Trumpet
  class User
    @@attributes = [:name]
    attr_reader *@@attributes
    
    def self.create(options)
      attributes = Trumpet::Request.post('/users', :parameters => options)
      User.new(attributes)
    end
    
    def self.find(name)
      User.new(Trumpet::Request.get("/users/#{name}"))
    end
    
    def delete
      !!Trumpet::Request.delete("/users/#{@name}")
    end
    
    protected
    
      def initialize(attributes)
        @@attributes.each do |attr|
          self.instance_variable_set(:"@#{attr.to_s}", attributes[attr.to_s]) if attributes[attr.to_s]
        end
      end
  end
end