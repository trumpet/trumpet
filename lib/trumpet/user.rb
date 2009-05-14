module Trumpet
  class User < Trumpet::Resource
    
    def self.create(options)
      attributes = Trumpet::Request.post('/users', options)
      User.new(attributes)
    end
    
    def self.find(name, options={})
      User.new(Trumpet::Request.get("/users/#{name}", options))
    end
    
    def delete(options={})
      options[:credentials] ||= @credentials
      options[:parse_response] = false
      !!Trumpet::Request.delete("/users/#{@name}", options)
    end
    
    def channels(options={})
      options[:credentials] ||= @credentials
      channels = Trumpet::Request.get("/users/#{name}/channels", options)
      channels.map { |attributes| Channel.new(attributes) }
    end
    
    def listeners(options={})
      options[:credentials] ||= @credentials
      listeners = Trumpet::Request.get("/users/#{name}/listeners", options)
      listeners.map { |attributes| Listener.new(attributes) }
    end
    
    def receivers(options={})
      options[:credentials] ||= @credentials
      receivers = Trumpet::Request.get("/users/#{name}/receivers", options)
      receivers.map { |attributes| Receiver.new(attributes) }
    end

  end
end