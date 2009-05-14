require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Channel" do
  
  before(:all) do
    @trumpet = Trumpet::Base.new :username => 'somedude', :password => 'somepassword'
    
    FakeWeb.register_uri :post, "somedude:somepassword@api.trumpet.io/messages", :file => "#{File.dirname(__FILE__)}/fixtures/messages/create"
  end
  
  it "should instantiate a message through the trumpet object with the proper attributes" do
    message = @trumpet.messages.new(
      :url => 'http://gnarly.com',
      :author => 'gnarlydude073',
      :avatar_url  => 'http://gnarly.com',
      :title => 'Radical Dude',
      :tags => 'gnarly, dudes, radical',
      :content => 'Bla bla bla, some short message.',
      :author_name => 'Gnarly Dude',
      :authored_at => 'Sep 1, 2008',
      :description => 'Some sort of description.',
      :location_string => 'San Francisco, CA'
    )
    
    message.url.should == 'http://gnarly.com'
    message.author.should == 'gnarlydude073'
    message.avatar_url.should == 'http://gnarly.com'
    message.title.should == 'Radical Dude'
    message.tags.should == 'gnarly, dudes, radical'
    message.content.should == 'Bla bla bla, some short message.'
    message.author_name.should == 'Gnarly Dude'
    message.description.should == 'Some sort of description.'
    message.location_string.should == 'San Francisco, CA'
  end
  
  it "should instantiate a message directly with the proper attributes" do
    message = Trumpet::Message.new(
      :url => 'http://gnarly.com',
      :author => 'gnarlydude073',
      :avatar_url  => 'http://gnarly.com',
      :title => 'Radical Dude',
      :tags => 'gnarly, dudes, radical',
      :content => 'Bla bla bla, some short message.',
      :author_name => 'Gnarly Dude',
      :authored_at => 'Sep 1, 2008',
      :description => 'Some sort of description.',
      :location_string => 'San Francisco, CA'
    )
    
    message.url.should == 'http://gnarly.com'
    message.author.should == 'gnarlydude073'
    message.avatar_url.should == 'http://gnarly.com'
    message.title.should == 'Radical Dude'
    message.tags.should == 'gnarly, dudes, radical'
    message.content.should == 'Bla bla bla, some short message.'
    message.author_name.should == 'Gnarly Dude'
    message.description.should == 'Some sort of description.'
    message.location_string.should == 'San Francisco, CA'
  end
end
