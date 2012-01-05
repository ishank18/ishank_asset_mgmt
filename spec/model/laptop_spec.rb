require 'spec_helper'

describe Laptop do 
	before(:each) do
		@valid_attributes = {
			:operating_system => "Ubuntu",
			:has_bag => true
		}
		@laptop = Laptop.new @valid_attributes
	end
	
	it "should have one asset" do
		@laptop.should have_one(:asset)
  end
	
end	
