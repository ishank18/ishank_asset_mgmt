require 'spec_helper'

describe NetworkDevice do 
	before(:each) do
		@valid_attributes = {
			:location => "2/6 Office",
		}
		@network_device = NetworkDevice.new @valid_attributes
	end
	
	it "should have one asset" do
		@network_device.should have_one(:asset)
  end
	
end	
