module Trumpet
  class Transmitter
    @@attributes = [
      :transmitter_id,
      :source_url,
      :tags,
      :location_string,
      :channel,
      :lat,
      :lng,
      :radius,
      :public,
      :created_at,
      :updated_at,
    ]
    
    attr_reader *@@attributes
    
    def self.create(options)
      Transmitter.new(Trumpet::Request.post('transmitters', :parameters => options))
    end
    
    def self.find(id)
      Transmitter.new(Trumpet::Request.get("/transmitters/#{id}"))
    end
    
    def delete
      Trumpet::Request.delete("/transmitters/#{@id}")
    end
    
    def listeners
      listeners = Trumpet::Request.get("/transmitters/#{@id}/listeners")
      listeners.map { |attributes| Listener.new(attributes) }
    end
    
    def broadcast(message)
      Trumpet::Request.post("/transmitters/#{@transmitter_id}/messages", :parameters => message.to_h, :parse_response => false)
    end
    
    
    protected
    
      def initialize(attributes)
        @@attributes.each do |attr|
          self.instance_variable_set(:"@#{attr.to_s}", attributes[attr.to_s]) if attributes[attr.to_s]
        end
      end
  end
end