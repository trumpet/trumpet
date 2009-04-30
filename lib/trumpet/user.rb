module Trumpet
  class User
    @@attributes = [:name]
    attr_reader *@@attributes
    
    def self.create(options)
      attributes = post('/users', options)
      User.new(attributes)
    end
    
    def self.find(name)
      attributes = get("/users/#{name}")
      User.new(attributes) if attributes["name"]
    end
    
    def delete
      self.class.delete("/users/#{@name}")
    end
  end
end