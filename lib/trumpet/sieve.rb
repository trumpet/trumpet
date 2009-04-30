module Trumpet
  class Sieve
    include HTTParty
    base_uri 'devour.cc:3000'
    
    @@options_attributes = [
      :keywords     , :location ,
      :via          , :to       ,
      :days         , :start    ,
      :end          , :expires  ,
      :foreign_id
    ]
    
    attr_accessor :id, :foreign_id, :name, :type, :created_at, :options
    
    @@options_attributes.each do |attribute|
      define_method "#{attribute}=" do |value|
        @options[attribute] = value
      end
      define_method attribute do
        @options[attribute]
      end
    end
    
    
    def initialize(options={})
      options.reject! { |key, value| value.nil? || (value.is_a?(String) && value.strip.empty?) }
      
      @options = {}
      @@options_attributes.each do |attribute|
        value = options[attribute] || options[attribute.to_s]
        @options[attribute] = value if value
      end
    end
        
    def pull
      add_to_server

      self.class.get("/sieves/#{id}").inject([]) do |memo, attributes|
        memo << Nugget.new(attributes)
      end
    end

    def subscribe
      wait_time ||= 2 # seconds

      while true
        results = pull
        results.each { |nugget| yield nugget }
        wait_time = results.nil? ? wait_time*2 : [wait_time/2, 2].max
        sleep(wait_time)
      end
    end
    
    def delete
      self.class.delete("/sieves/#{@id}")
    end
        
    def add_to_server
      unless @id
        attributes = self.class.post("/sieves", :query => options)
        @id   = attributes['id']
        @type = attributes['type']
        @name = attributes['name']
      end
    end
    
    def self.index
      get("/sieves")
    end
    
    def self.find(id)
      attributes = get("/sieves/?id=#{id}").first
      instantiate(attributes)
    end
    
    def self.find_by_foreign_id(foreign_id)
      sieve_attributes = get("/sieves/?foreign_id=#{foreign_id}")
      sieve_attributes.collect { |attributes| instantiate(attributes) }
    end
    
    def self.create(options={})
      sieve = new(options)
      sieve.add_to_server
      sieve
    end

    
    private
    
      def self.instantiate(attributes)
        sieve = allocate
        
        sieve.id = attributes['id']
        sieve.options = attributes['options']
        sieve.type = attributes['type']
        sieve.name = attributes['name']
        
        sieve
      end
  end
end