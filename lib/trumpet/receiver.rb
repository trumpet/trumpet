module Trumpet
  class Receiver < Trumpet::Resource
    
    def self.create(options)
      Receiver.new(Trumpet::Request.post("/receivers", options))
    end
    
    def self.find(id, options={})
      Receiver.new(Trumpet::Request.get("/receivers/#{id}", options))
    end
    
    def delete(options={})
      options[:credentials] ||= @credentials
      options[:parse_response] = false
      !!Trumpet::Request.delete("/receivers/#{@id}", options)
    end
    
    def messages(options={})
      options[:credentials] ||= @credentials
      messages = Trumpet::Request.get("/receivers/#{@id}/messages", options)
      messages.map { |attributes| Message.new(attributes) }
    end
    
    def listen
      #TODO: impliment this
    end

  end
end