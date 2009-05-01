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
    
    def to_h
      @@attributes.inject({}) { |hash, attribute| hash[attribute] = self.send(attribute); hash }
    end
  end
end