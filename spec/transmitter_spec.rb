require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Transmitter" do
  
  before(:all) do
    @trumpet = Trumpet::Base.new :username => "somedude", :password => "somepassword"
    
    FakeWeb.register_uri :post,   "#{AUTHENTICATED_URI}/transmitters",            :file => "#{File.dirname(__FILE__)}/fixtures/transmitters/create"
    FakeWeb.register_uri :get,    "#{AUTHENTICATED_URI}/transmitters/1",          :file => "#{File.dirname(__FILE__)}/fixtures/transmitters/find"
    FakeWeb.register_uri :delete, "#{AUTHENTICATED_URI}/transmitters/1",           :string => ["204", "OK"]
    FakeWeb.register_uri :post,   "#{AUTHENTICATED_URI}/transmitters/1/messages",  :string => ["204", "OK"]
  end
  
  it "should let me create a transmitter" do
    transmitter = @trumpet.transmitters.create :tags => 'dudes, gnarly, rad'
    transmitter.tags.should == 'dudes, gnarly, rad'
  end
  
  it "should let me delete a transmitter" do
    transmitter = @trumpet.transmitters.find(1)
    transmitter.tags.should == 'dudes, gnarly, rad'
  end
  
  it "should let me broadcast a message into a receiver" do
    transmitter = @trumpet.transmitters.find(1)
    transmitter.broadcast(Trumpet::Message.new(:content => 'dude, awesome')).should == true
  end
  
end
