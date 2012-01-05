require 'spec_helper'

describe Asset do 
	before(:each) do
		@valid_attributes = {
			:status => "spare", 
			:name => "Test Name", 
			:currency_unit => "&#8377;", 
			:cost => "100.0", 
			:serial_number => "YUIYIU78sdf789IU", 
			:vendor => "Test", 
			:purchase_date => DateTime.now - 6, 
			:description => "Test Desc", 
			:additional_info => "Test ADD Info",
			:resource_type => "Laptop",
			:resource_id => 1
		}
		@asset = Asset.new @valid_attributes
	end

	it "should have a name" do
		@asset.should validate_presence_of :name
	end
	
	it "should have a status" do
		@asset.should validate_presence_of :status
	end
	
	it "should have cost with maximum length of 10" do
		@asset.cost = 1000000000000000000
		@asset.should_not be_valid
		@asset.should have(1).error_on(:cost)
		
		@asset.cost = 100.0
		@asset.should be_valid
	end
	
	it "should have a numeric cost" do
		@asset.cost = "abcd"
		@asset.should_not be_valid
		@asset.should have(1).error_on(:cost)

		@asset.cost = 100.0
		@asset.should be_valid
	end
	
	it "should have a cost" do
		@asset.should validate_presence_of :cost
	end	
	
	it "should have a resource type" do
		@asset.should validate_presence_of :resource_type
	end
	
	it "should have a unique serial number" do
		@asset.save
		@asset_copy = Asset.new @valid_attributes
		@asset_copy.should_not be_valid
		@asset_copy.should have(1).error_on(:serial_number)
	end
	
	it "should have a serial number" do
		@asset.should validate_presence_of :serial_number
	end
	
	it "should have a purchase date" do
		@asset.should validate_presence_of :purchase_date
	end
	
	it "should have a vendor" do
		@asset.should validate_presence_of :vendor
	end
	
	it "should not have future purchase date" do
		@asset.purchase_date = DateTime.now + 2
		@asset.should_not be_valid
		
		@asset.purchase_date = DateTime.now - 2
		@asset.should be_valid
	end
	
	it "should have one resource" do
		@asset.should belong_to :resource
	end
	
	it "should have many asset employee mapping" do
		@asset.should have_many :asset_employee_mappings
	end
	
	it "should have many employee" do
		@asset.should have_many :employees
	end
	
	it "should have and belong to many tags" do
		@asset.should have_and_belong_to_many :tags
	end
	
end	
