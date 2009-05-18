require File.dirname(__FILE__) + '/spec_helper.rb'

describe "User" do
  
  before(:all) do
    @trumpet = Trumpet::Base.new :username => "somedude", :password => "somepassword"
    
    FakeWeb.register_uri :post,   "#{AUTHENTICATED_URI}/users",                   :file => "#{File.dirname(__FILE__)}/fixtures/users/create"
    FakeWeb.register_uri :get,    "#{AUTHENTICATED_URI}/users/raddude",           :file => "#{File.dirname(__FILE__)}/fixtures/users/show"
    FakeWeb.register_uri :put,    "#{AUTHENTICATED_URI}/users/raddude",           :file => "#{File.dirname(__FILE__)}/fixtures/users/put"
    FakeWeb.register_uri :delete, "#{AUTHENTICATED_URI}/users/raddude",           :string => ["204", "OK"]
    FakeWeb.register_uri :get,    "#{AUTHENTICATED_URI}/users/raddude/channels",  :file => "#{File.dirname(__FILE__)}/fixtures/users/channels"
    FakeWeb.register_uri :get,    "#{AUTHENTICATED_URI}/users/raddude/listeners", :file => "#{File.dirname(__FILE__)}/fixtures/users/listeners"
    FakeWeb.register_uri :get,    "#{AUTHENTICATED_URI}/users/raddude/receivers", :file => "#{File.dirname(__FILE__)}/fixtures/users/receivers"
  end
  
  it "should let me create a new user" do
    user = @trumpet.users.create :name => 'raddude', :password => 'raddude'
    user.name.should == 'raddude'
  end
  
  it "should let me find an existing user by name" do
    user = @trumpet.users.find 'raddude'
    user.name.should == 'raddude'
  end

  # TODO: Note yet supported on backend
  # it "should let me update an existing user" do
  #   user = @trumpet.users.find 'raddude'
  #   
  #   user.update(:name => 'radicaldude')
  #   user.name.should == 'radicaldude'
  # end
  
  it "should let me delete an existing user" do
    user = @trumpet.users.find 'raddude'
    user.delete.should == true
  end
  
  it "should let me find all of an existing user's channels" do
    user = @trumpet.users.find 'raddude'
    channels = user.channels
    channels.length.should == 3
    channels[0].name.should == 'channel1'
    channels[1].name.should == 'channel2'
    channels[2].name.should == 'channel3'
  end
  
  it "should let me find all of an existing user's listeners" do
    user = @trumpet.users.find 'raddude'
    listeners = user.listeners
    listeners.length.should == 3
    listeners[0].uri.should == 'mailto://someraddude@mailinator.com'
    listeners[1].uri.should == 'mailto://someotherdude@mailinator.com'
    listeners[2].uri.should == 'mailto://andanotherdude@mailinator.com'
  end
  
  it "should let me find all of an existing user's receivers" do
    user = @trumpet.users.find 'raddude'
    receivers = user.receivers
    receivers.length.should == 3
    receivers[0].keywords.should == 'other things, rad dudes'
    receivers[1].keywords.should == 'gnarly things, radical things'
    receivers[2].keywords.should == 'other sweet things, pretty sweet stuff'
  end
  
end
