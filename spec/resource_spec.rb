require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Resource" do
  
  before(:all) do
    @trumpet = Trumpet::Base.new :username => 'somedude', :password => 'somepassword'
    
    FakeWeb.register_uri :get,  "#{AUTHENTICATED_URI}/channels/radical",  :file => "#{File.dirname(__FILE__)}/fixtures/channels/show"
    
    @channel_attributes = {
      :receiver_id  => 2,   :name           => "radical", 
      :updated_at   => nil, :description    => nil, 
      :owner_id     => 1,   :transmitter_id => 2, 
      :created_at   => nil
    }
  end
  
  it "should build up attr_readers from all passed in attributes" do
    channel = @trumpet.channels.find 'radical'
     
    # Verify that all methods are there and all values are set properly
    @channel_attributes.keys.each do |attribute|
      channel.send(attribute).should == @channel_attributes[attribute]
    end
  end
  
  it "should properly convert itself into a hash" do
    channel = @trumpet.channels.find 'radical'  
    channel.to_h.should == @channel_attributes
  end
  
end
