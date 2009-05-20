require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Listener" do
  
  before(:all) do
    @trumpet = Trumpet::Base.new :username => "somedude", :password => "somepassword"
    
    FakeWeb.register_uri :post,   "#{AUTHENTICATED_URI}/receivers/1/listeners", :file => "#{File.dirname(__FILE__)}/fixtures/listeners/create"
    FakeWeb.register_uri :get,    "#{AUTHENTICATED_URI}/listeners/1",           :file => "#{File.dirname(__FILE__)}/fixtures/listeners/find"
    FakeWeb.register_uri :get,    "#{AUTHENTICATED_URI}/listeners/2",           :file => "#{File.dirname(__FILE__)}/fixtures/listeners/sms"
    FakeWeb.register_uri :get,    "#{AUTHENTICATED_URI}/listeners/3",           :file => "#{File.dirname(__FILE__)}/fixtures/listeners/irc"
    FakeWeb.register_uri :get,    "#{AUTHENTICATED_URI}/listeners/4",           :file => "#{File.dirname(__FILE__)}/fixtures/listeners/im"
    FakeWeb.register_uri :get,    "#{AUTHENTICATED_URI}/listeners/5",           :file => "#{File.dirname(__FILE__)}/fixtures/listeners/twitter"
    FakeWeb.register_uri :delete, "#{AUTHENTICATED_URI}/listeners/1",           :string => ["204", "OK"]
  end
  
  it "should let me create a listener" do
    listener = @trumpet.listeners.create :receiver_id => 1, :uri => 'mailto://someraddude@mailinator.com'
    listener.uri.should == 'mailto:someraddude@mailinator.com'
  end
  
  it "should let me find an existing listener" do
    listener = @trumpet.listeners.find(1)
    listener.uri.should == 'mailto:someraddude@mailinator.com'
  end
  
  it "should let me delete an existing listener" do
    listener = @trumpet.listeners.find(1)
    listener.delete.should == true
  end
  
  it "should be able to describe it's delivery method" do
    email_listener = @trumpet.listeners.find(1)
    email_listener.delivery_method.should == 'Email'
    email_listener.delivery_address.should == 'someraddude@mailinator.com'
    
    sms_listener = @trumpet.listeners.find(2)
    sms_listener.delivery_method.should == 'SMS'
    sms_listener.delivery_address.should == '15555555555'
    
    irc_listener = @trumpet.listeners.find(3)
    irc_listener.delivery_method.should == 'IRC'
    irc_listener.delivery_address.should == 'irc.trumpet.io#raddudes'
    
    im_listener = @trumpet.listeners.find(4)
    im_listener.delivery_method.should == 'IM'
    im_listener.delivery_address.should == 'somedude@mailinator.com'
            
    twitter_listener = @trumpet.listeners.find(5)
    twitter_listener.delivery_method.should == 'Twitter'
    twitter_listener.delivery_address.should == 'twitterdude'
  end
end
