require 'spec_helper'

describe AssetEmployeeMapping do 
	before(:each) do
		@valid_attributes = {
			:asset_id => 15, 
			:employee_id => 9, 
			:assignment_type => "Temporary", 
			:date_issued => DateTime.now - 6,
			:date_returned => DateTime.now + 6,
			:remark => "test Remark"
		}
		@aem = AssetEmployeeMapping.new @valid_attributes
	end
	
	it "should have a date issued" do
		should validate_presence_of :date_issued
	end
	
	it "should have a asset id" do
		should validate_presence_of :asset_id
	end
	
	it "should have a employee id" do
		should validate_presence_of :employee_id
	end

	it "should have date returned greater than date issued" do
		@aem.date_issued = DateTime.now + 2 
		@aem.date_returned = DateTime.now - 2 
		@aem.should_not be_valid
		
		@aem.date_issued = DateTime.now - 2 
		@aem.date_returned = DateTime.now + 2 
		@aem.should be_valid
		
	end
	
	it "should belong to a asset" do
		should belong_to(:asset)
	end
	
	it "should belong to a employee" do
		should belong_to(:employee)
	end
	
end
