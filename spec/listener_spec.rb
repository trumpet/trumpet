require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Listener" do
  
  before(:all) do
    @trumpet = Trumpet::Base.new :username => "somedude", :password => "somepassword"
    
    FakeWeb.register_uri :post,   "#{AUTHENTICATED_URI}/receivers/1/listeners", :file => "#{File.dirname(__FILE__)}/fixtures/listeners/create"
    FakeWeb.register_uri :get,    "#{AUTHENTICATED_URI}/listeners/1",           :file => "#{File.dirname(__FILE__)}/fixtures/listeners/find"
    FakeWeb.register_uri :delete, "#{AUTHENTICATED_URI}/listeners/1",           :string => ["204", "OK"]
  end
  
  it "should let me create a listener" do
    listener = @trumpet.listeners.create :receiver_id => 1, :uri => 'mailto://someraddude@mailinator.com'
    listener.uri.should == 'mailto://someraddude@mailinator.com'
  end
  
  it "should let me find an existing listener" do
    listener = @trumpet.listeners.find(1)
    listener.uri.should == 'mailto://someraddude@mailinator.com'
  end
  
  it "should let me delete an existing listener" do
    listener = @trumpet.listeners.find(1)
    listener.delete.should == true
  end
end
