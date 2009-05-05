module Trumpet
  class Channel
    @@attributes = [
      :name,
      :receiver_id,
      :transmitter_id,
      :owner_id,
      :created_at,
      :updated_at
    ]
    
    attr_reader *@@attributes
    
    def self.create(options)
      Channel.new(Trumpet::Request.post('/channels', :parameters => options))
    end
    
    def self.find(name)
      Channel.new(Trumpet::Request.get("/channels/#{name}"))
    end
    
    def self.all
      Trumpet::Request.get('/channels').map { |attributes| Channel.new(attributes) }
    end
    
    def self.all_by_user(name)
      channels = Trumpet::Request.get("/users/#{name}/channels")
      channels.map { |attributes| Channel.new(attributes) }
    end
        
    def broadcast(message)
     Trumpet::Request.post("/channels/#{@name}/messages", :parameters => message.to_h, :parse_response => false)
    end
    
    def messages
      messages = Trumpet::Request.get("/channels/#{@name}/messages")
      messages.map { |attributes| Message.new(attributes) }
    end

    protected
    
      def initialize(attributes)
        @@attributes.each do |attr|
          self.instance_variable_set(:"@#{attr.to_s}", attributes[attr.to_s]) if attributes[attr.to_s]
        end
      end
  end
end
