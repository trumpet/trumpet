module Trumpet
  class Message
    
    @@attributes = [
      :url        , :created_by_id,
      :author     , :author_name,
      :avatar_url , :authored_at,
      :title      , :description,
      :tags       , :location_string,
      :lat        , :lng,
      :radius     , :channel,
      :public     , :authorized_receiver_owners,
      :content    , :id,
      :source
    ]
    
    attr_accessor *@@attributes

    def initialize(options)
      parameters = options[:parameters] ? options[:parameters] : options
      @@attributes.each do |attr|
        self.send "#{attr.to_s}=".to_sym, (parameters[attr] || parameters[attr.to_s])
      end
    end
    
    def self.create(request, attributes)
      !!request.post('/messages', :parameters => self.to_h, :parse_response => false)
    end
    
    def to_h
      @@attributes.inject({}) { |hash, attribute| hash[attribute] = self.send(attribute); hash }
    end
  end
end
