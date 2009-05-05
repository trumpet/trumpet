module Trumpet
  class Listener
    @@attributes = [
      :receiver_id,
      :owner_id,
      :uri,
      :schedule,
      :created_at,
      :updated_at,
    ]
    
    attr_reader *@@attributes
    
    
    def self.create(options)
      if options[:receiver_id]
        Listener.new(Trumpet::Request.post("/receivers/#{options[:receiver_id]}/listeners", :parameters => options))
      else
        raise Trumpet::BadRequest, "Must specify a receiver id when creating a listener"
      end
    end
    
    def self.find(id)
      Listener.new(Trumpet::Request.get("/listeners/#{id}"))
    end
    
    def self.all_by_user(name)
      listeners = Trumpet::Request.get("/users/#{name}/listeners")
      listeners.map { |attributes| Listener.new(attributes) }
    end
    
    def self.delete
      !!Trumpet::Request.delete("/listeners/#{@id}")
    end
    
    
    protected
    
      def initialize(attributes)
        @@attributes.each do |attr|
          self.instance_variable_set(:"@#{attr.to_s}", attributes[attr.to_s]) if attributes[attr.to_s]
        end
      end
  end
end