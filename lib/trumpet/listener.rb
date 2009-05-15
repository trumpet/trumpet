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
    
    def receiver(options={})
      @receiver ||= begin
        options[:credentials] ||= @credentials
        Trumpet::Receiver.new(Trumpet::Request.get("/receivers/#{receiver_id}", options))
      end
    end
    
    def delivery_method
      case URI.parse(uri).scheme
			when 'mailto' then 'Email'
			when 'tel' then 'SMS'
			when 'twitter' then 'Twitter'
		  when 'irc' then 'IRC'
			when 'im' then 'IM'
			end
    end
    
    def delivery_address
      case URI.parse(uri).scheme
			when 'mailto' then URI.parse(uri).to
			when 'tel' then URI.parse(uri).opaque
			when 'twitter' then URI.parse(uri).opaque
		  when 'irc'
		    url = URI.parse(uri)
        "#{url.host}##{url.fragment}"
			when 'im'
			  url = URI.parse(uri)
        "#{url.user}@#{url.host}"
			end
    end
    
  end
end