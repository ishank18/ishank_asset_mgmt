require 'spec_helper'

describe HomeController do
  render_views
  
  before do
  	@tag = mock_model(Tag, :save => true, :name => "ubuntu")    
  	@tags = [@tag]
  	@asset = mock_model(Asset, :save => true, "name"=>"Test Name", "currency_unit"=>"&#8377;", "cost"=>"100.0", "serial_number"=>"YUIYIU78sdf789IU", "vendor"=>"Test", "purchase_date"=>"29/09/2011", "resource_attributes"=>{"operating_system"=>"TEST OS", "has_bag"=>"false"}, "description"=>"Test Desc", "additional_info"=>"Test ADD Info")
  	@assets = [@asset]
		@admin = mock_model(Admin, :save => true, :email => "admin@example.com", :password => "password", :password_confirmation => "password")
		controller.stub!(:current_admin).and_return(@admin)
  end
  
  describe "INDEX" do
    it "get request should be successful" do
      Tag.should_receive(:all).and_return(@tags)
      @tag.should_receive(:assets).and_return(@assets)
      get :index
      response.should be_success
      response.should render_template("index")
    end
  end
  
end  
