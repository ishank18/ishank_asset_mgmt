require 'spec_helper'

describe HomeController do
  render_views
  
  before do
  	@tag = mock_model(Tag, :save => true, :id => 1, :name => "ubuntu")    
  	@tags = [@tag]
		@admin = mock_model(Admin, :email => "admin@example.com", :password => "password", :password_confirmation => "password")
		@admin.skip_confirmation!
		controller.stub!(:current_admin).and_return(@admin)
  end
  
  describe "INDEX" do
    it "get request should be successful" do
      Tag.should_receive(:all).and_return(@tags)
      get :index
      response.should be_success
      response.should render_template("index")
    end
  end
  
end  
