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
    
    def channels
      channels = Trumpet::Request.get("/users/#{@name}/channels")
      channels.map { |attributes| Trumpet::Channel.new(attributes) }
    end
    
    def listeners
      listeners = Trumpet::Request.get("/users/#{@name}/listeners")
      listeners.map { |attributes| Trumpet::Channel.new(attributes) }
    end
    
    def receivers
      receivers = Trumpet::Request.get("/users/#{@name}/receivers")
      receivers.map { |attributes| Trumpet::Channel.new(attributes) }
    end
    
    def transmitters
      transmitters = Trumpet::Request.get("/users/#{@name}/transmitters")
      transmitters.map { |attributes| Trumpet::Transmitter.new(attributes) }
    end
    
    protected
    
      def initialize(attributes)
        @@attributes.each do |attr|
          self.instance_variable_set(:"@#{attr.to_s}", attributes[attr.to_s]) if attributes[attr.to_s]
        end
      end
  end
end