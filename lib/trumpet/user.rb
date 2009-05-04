module Trumpet
  class User
    @@attributes = [:id, :name]
    attr_reader *@@attributes
    
    def self.create(options)
      attributes = Trumpet::Request.post('/users', :parameters => options)
      User.new(attributes)
    end
    
    def self.find(name)
      User.new(Trumpet::Request.get("/users/#{name}"))
    end
    
    def self.authenticate(name, password)
      # TODO: write this method
    end
    
    def delete
      !!Trumpet::Request.delete("/users/#{@name}")
    end
    
    def channels
      Trumpet::Channel.all_by_user(@name)
    end
    
    def listeners
      Trumpet::Listener.all_by_user(@name)
    end
    
    def receivers
      Trumpet::Receiver.all_by_user(@name)
    end
    
    def transmitters
      Trumpet::Transmitter.all_by_user(@name)
    end
    
    protected
    
      def initialize(attributes)
        @@attributes.each do |attr|
          self.instance_variable_set(:"@#{attr.to_s}", attributes[attr.to_s]) if attributes[attr.to_s]
        end
      end
  end
end