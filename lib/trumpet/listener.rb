module Trumpet
  class Listener < Trumpet::Resource
    
    def self.create(options)
      if options[:parameters][:receiver_id]
        Listener.new(Trumpet::Request.post("/receivers/#{options[:parameters][:receiver_id]}/listeners", options))
      else
        raise Trumpet::BadRequest, "Must specify a receiver id when creating a listener"
      end
    end
    
    def self.find(id, options={})
      Listener.new(Trumpet::Request.get("/listeners/#{id}", options))
    end
    
    def delete(options={})
      options[:credentials] ||= @credentials
      options[:parse_response] = false
      !!Trumpet::Request.delete("/listeners/#{@id}", options)
    end
    
  end
end