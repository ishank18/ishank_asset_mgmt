require 'spec_helper'

describe MobilePhone do 
	before(:each) do
		@valid_attributes = {
			:operating_system => "Ubuntu",
		}
		@mobile_phone = MobilePhone.new @valid_attributes
	end
	
	it "should have one asset" do
		@mobile_phone.should have_one(:asset)
  end
	
end	
