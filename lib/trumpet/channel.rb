module Trumpet
  class Channel < Trumpet::Resource
    
    def self.create(options)
      Channel.new(Trumpet::Request.post('/channels', options))
    end
    
    def self.find(name, options={})
      Channel.new(Trumpet::Request.get("/channels/#{name}", options))
    end
    
    def self.all(options={})
      Trumpet::Request.get('/channels', options).map { |attributes| Channel.new(attributes) }
    end
    
    def self.all_by_user(name, options={})
      channels = Trumpet::Request.get("/users/#{name}/channels", options)
      channels.map { |attributes| Channel.new(attributes) }
    end
    
    def delete(options={})
      options[:credentials] ||= @credentials
      !!Trumpet::Request.delete("/channels/#{name}", :parse_response => false, :credentials => options[:credentials])
    end
        
    def broadcast(message, options={})
      options[:credentials] ||= @credentials
      !!Trumpet::Request.post("/channels/#{@name}/messages", :parameters => message.to_h, :parse_response => false, :credentials => options[:credentials])
    end
    
    def messages(options={})
      options[:credentials] ||= @credentials
      messages = Trumpet::Request.get("/channels/#{@name}/messages", options)
      messages.map { |attributes| Message.new(attributes) }
    end
    
  end
end
