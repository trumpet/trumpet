require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Receiver" do
  
  before(:all) do
    @trumpet = Trumpet::Base.new :username => "somedude", :password => "somepassword"
    
    FakeWeb.register_uri :post,   "#{AUTHENTICATED_URI}/receivers",             :file => "#{File.dirname(__FILE__)}/fixtures/receivers/create"
    FakeWeb.register_uri :get,    "#{AUTHENTICATED_URI}/receivers/1",           :file => "#{File.dirname(__FILE__)}/fixtures/receivers/find"
    FakeWeb.register_uri :delete, "#{AUTHENTICATED_URI}/receivers/1",           :string => ["204", "OK"]
    FakeWeb.register_uri :get,    "#{AUTHENTICATED_URI}/receivers/1/messages",  :file => "#{File.dirname(__FILE__)}/fixtures/receivers/messages"
  end
  
  it "should let me create a receiver" do
    receiver = @trumpet.receivers.create
    receiver.name.should == "Everything "  
  end
  
  it "should let me find an existing receiver" do
    receiver = @trumpet.receivers.find(1)
    receiver.name.should == "Everything "
  end
  
  it "should let me delete an existing receiver" do
    receiver = @trumpet.receivers.find(1)
    receiver.delete.should == true
  end
  
  it "should let me fetch all of the messages for a given receiver" do
    receiver = @trumpet.receivers.find(1)
    messages = receiver.messages
    messages.length.should == 1
    messages.first.content.should == 'yay'
  end
end
