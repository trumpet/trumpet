module Trumpet
  class Listener
    @@attributes = [
      :receiver_id,
      :uri,
      :start,
      :end,
      :days,
      :created_at,
      :updated_at,
    ]
    
    attr_reader *@@attributes
    
    
    def self.create(options)
      Listener.new(Trumpet::Request.post('/listeners', :parameters => options))
    end
    
    def self.find(id)
      Listener.new(Trumpet::Request.get("/listeners/#{id}"))
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