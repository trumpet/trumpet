module Trumpet
  class Message
    @@attributes = [
      :url        , :creator_id,
      :author     , :author_name,
      :avatar_url , :authored_at,
      :title      , :description,
      :tags       , :location_string,
      :lat        , :lng,
      :radius     , :channel,
      :public     , :authorized_receiver_owners,
      :content    , :created_at,
      :updated_at , :id
    ]
    
    #TODO: created_at and updated_at maybe not writable
    

    attr_accessor *@@attributes

    def initialize(attributes)
      @@attributes.each do |attr|
        self.send "#{attr.to_s}=".to_sym, (attributes[attr] || attributes[attr.to_s])
      end
    end
    
    def self.create(attributes)
      message = Message.new(attributes)
      message.broadcast
      message
    end
    
    # Post a message to the server, but only if it didn't come from the server
    def broadcast
      
      puts "Self to h: #{self.to_h}"
      puts "And plain to h: #{to_h}"
      
      unless @id
        attributes = Trumpet::Request.post('/messages', :parameters => self.to_h)
        @@attributes.each do |attr|
          self.send "#{attr.to_s}=".to_sym, (attributes[attr] || attributes[attr.to_s])
        end
      end
    end
    
    def to_h
      @@attributes.inject({}) { |hash, attribute| hash[attribute] = self.send(attribute); hash }
    end
  end
end