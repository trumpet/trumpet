require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Request" do
  
  before(:all) do
    FakeWeb.register_uri :get,  "#{UNAUTHENTICATED_URI}/badrequest",    :status => ["400", "Bad Request"],  :string => ['Bad Request'].to_json
    FakeWeb.register_uri :get,  "#{UNAUTHENTICATED_URI}/unauthorized",  :status => ["401", "Unauthorized"], :string => ['Unauthorized'].to_json
    FakeWeb.register_uri :get,  "#{UNAUTHENTICATED_URI}/forbidden",  :status => ["403", "Forbidden"], :string => ['Forbidden'].to_json
    FakeWeb.register_uri :get,  "#{UNAUTHENTICATED_URI}/notfound",  :status => ["404", "Not Found"], :string => ['Not Found'].to_json
    FakeWeb.register_uri :get,  "#{UNAUTHENTICATED_URI}/methodnotallowed",  :status => ["405", "Method Not Allowed"], :string => ['Method Not Allowed'].to_json
    FakeWeb.register_uri :get,  "#{UNAUTHENTICATED_URI}/conflict",  :status => ["409", "Conflict"], :string => ['Conflict'].to_json
    FakeWeb.register_uri :get,  "#{UNAUTHENTICATED_URI}/internalservererror",  :status => ["500", "Internal Server Error"], :string => ['Internal Server Error'].to_json
    FakeWeb.register_uri :get,  "#{UNAUTHENTICATED_URI}/notimplemented",  :status => ["501", "Not Implemented"], :string => ['Not Implemented'].to_json
  end
  
  context "when handling errors" do
    it "should throw a BadRequest exception when it receives a 400 code" do
      lambda { Trumpet::Request.get('/badrequest', :parse_response => false) }.should raise_error(Trumpet::BadRequest)
    end
    
    it "should throw an Unauthorized exception when it receives a 401 code" do
      lambda { Trumpet::Request.get('/unauthorized', :parse_response => false) }.should raise_error(Trumpet::Unauthorized)
    end
    
    it "should throw a Forbidden exception when it receives a 403 code" do
      lambda { Trumpet::Request.get('/forbidden', :parse_response => false) }.should raise_error(Trumpet::Forbidden)
    end
    
    it "should throw a NotFound exception when it receives a 404 code" do
      lambda { Trumpet::Request.get('/notfound', :parse_response => false) }.should raise_error(Trumpet::NotFound)
    end
    
    it "should throw a MethodNotAllowed exception when it receives a 405 code" do
      lambda { Trumpet::Request.get('/methodnotallowed', :parse_response => false) }.should raise_error(Trumpet::MethodNotAllowed)
    end
    
    it "should throw a Conflict exception when it receives a 409 code" do
      lambda { Trumpet::Request.get('/conflict', :parse_response => false) }.should raise_error(Trumpet::Conflict)
    end
    
    it "should throw an InternalServerError exception when it receives a 500 code" do
      lambda { Trumpet::Request.get('/internalservererror', :parse_response => false) }.should raise_error(Trumpet::InternalServerError)
    end
    
    it "should throw a NotImplimented exception when it receives a 501 code" do
      lambda { Trumpet::Request.get('/notimplemented', :parse_response => false) }.should raise_error(Trumpet::NotImplemented)
    end
  end
end
