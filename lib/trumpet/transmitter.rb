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
      attributes = HTTP::post('transmitters', :query => options)
      Transmitter.new(attributes)
    end
    
    def self.find(id)
      attributes = get("/transmitters/#{id}")
      Transmitter.new(attributes)
    end
    
    def delete
      self.class.delete('/')
    end
    
    def listeners
      listeners = self.class.get("/transmitters/#{id}/listeners")
      listeners.map { |attributes| Listener.new(attributes) }
    end
    
    def broadcast(message)
      self.class.post("/transmitters/#{@transmitter_id}/messages", :query => message.to_h)
    end

  end
end