module Trumpet
  class Channel
    @@attributes = [
      :name,
      :default_receiver,
      :created_at,
      :updated_at
    ]
    
    attr_reader *@@attributes
    
    def self.create(options)
      Channel.new(Http.post('/channels', :parameters => options))
    end
    
    def self.find(name)
      Channel.new(HTTP.post("/channels/#{name}"))
    end
    
    def self.all
      HTTP::get('/channels').map { |attributes| Channel.new(attributes) }
    end
    
    def default_receiver
      if @default_receiver
        @default_receiver
      else
        Receiver.new(HTTP::get('')) # TODO: find out the url for this
      end
    end
    
    def broadcast()
      
    end
    
    def messages
      messages = HTTP.get("/channels/#{@name}/messages")
      messages.map { |attributes| Message.new(attributes) }
    end

    # protected
    # 
    #   def initialize(attributes)
    #     @@attributes.each do |attr|
    #       self.instance_variable_set(:"@#{attr.to_s}", attributes[attr.to_s]) if attributes[attr.to_s]
    #     end
    #   end
  end
end