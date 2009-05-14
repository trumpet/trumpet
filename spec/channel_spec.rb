require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Channel" do
  
  before(:all) do
    @trumpet = Trumpet::Base.new :username => 'somedude', :password => 'somepassword'
    
    FakeWeb.register_uri :post, "somedude:somepassword@api.trumpet.io/channels", :file => "#{File.dirname(__FILE__)}/fixtures/channels/create"
    FakeWeb.register_uri :get, "somedude:somepassword@api.trumpet.io/channels", :file => "#{File.dirname(__FILE__)}/fixtures/channels/all"
    FakeWeb.register_uri :get, "somedude:somepassword@api.trumpet.io/channels/radical", :file => "#{File.dirname(__FILE__)}/fixtures/channels/show"
    FakeWeb.register_uri :post, "somedude:somepassword@api.trumpet.io/channels/radical/messages", :status => ["204", "OK"]
    FakeWeb.register_uri :get, "somedude:somepassword@api.trumpet.io/channels/radical/messages", :file => "#{File.dirname(__FILE__)}/fixtures/channels/messages"
  end
  
  it 'should let me create a channel' do
    channel = @trumpet.channels.create :name => 'radical'
    channel.name.should == 'radical'
  end
  
  it 'should return a list of all channels' do
    channels = @trumpet.channels.all
    channels.length.should == 2
    channels.first.name.should == 'cool'
    channels.last.name.should == 'radical'
  end
  
  it 'should find a channel by name' do
    channel = @trumpet.channels.find 'radical'
    channel.name.should == 'radical'
  end
  
  it 'should allow me to broadcast a message through a channel' do
    channel = @trumpet.channels.find 'radical'
    channel.broadcast(Trumpet::Message.new(:content => 'dude, awesome')).should == true
  end
  
  it 'should return all messages in a given channel' do
    channel = @trumpet.channels.find 'radical'
    messages = channel.messages
    messages.length.should == 3
  end
  
end
