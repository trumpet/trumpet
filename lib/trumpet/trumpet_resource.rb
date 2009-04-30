module Trumpet
  module TrumpetResource
    def to_h
      @@attributes.inject({}) { |hash, attribute| hash[attribute] = self.send(attribute); hash }
    end
  end
end