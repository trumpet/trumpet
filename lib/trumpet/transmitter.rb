module Trumpet
  class Transmitter < Trumpet::Resource
    
    def self.create(options)
      Transmitter.new(Trumpet::Request.post('/transmitters', options))
    end
    
    def self.find(id, options={})
      Transmitter.new(Trumpet::Request.get("/transmitters/#{id}", options))
    end
    
    def delete(options={})
      Trumpet::Request.delete("/transmitters/#{@id}", options)
    end
    
    def broadcast(message, options={})
      options[:credentials] ||= @credentials
      options[:parameters] = message.to_h
      options[:parse_response] = false
      !!Trumpet::Request.post("/transmitters/#{@id}/messages", options)
    end
    
  end
end