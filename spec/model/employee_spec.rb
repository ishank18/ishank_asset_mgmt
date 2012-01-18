require 'spec_helper'

describe Employee do 
	before(:each) do
		@valid_attributes = {
			:employee_id => "52", 
			:name => "Jagdeep Singh", 
			:email => "jagdeep.singh@vinsol.com"
		}
		@employee = Employee.new @valid_attributes
	end
	
	it "should have a email" do
		@employee.should validate_presence_of :email
	end
	
	it "should have a unique email" do
		@employee.save
		@employee_copy = Employee.new( :employee_id => "53", :name => "Ishank Gupta", :email => "jagdeep.singh@vinsol.com" )
		@employee_copy.should_not be_valid
		@employee_copy.should have(1).error_on(:email)
	end
	
	it "should have a valid email" do
		@employee.email = "test@test"
		@employee.should_not be_valid
		@employee.should have(1).error_on(:email)
		
		@employee.email = "testtest.com"
		@employee.should_not be_valid
		@employee.should have(1).error_on(:email)
		
		@employee.email = "test@test.com"
		@employee.should be_valid
	end
	
	it "should have a employee id" do
		@employee.employee_id = nil
		@employee.should_not be_valid
		@employee.errors[:employee_id].should == ["Id cannot be blank"]
	end
	
	it "should have a integer employee id" do
		@employee.employee_id = "abc"
		@employee.should_not be_valid

		@employee.employee_id = 1.0
		@employee.should_not be_valid
		
		@employee.employee_id = 1
		@employee.should be_valid
	end
	
	it "should have a positive employee id" do
		@employee.employee_id = -4
		@employee.should_not be_valid
	end
	
	it "should have a unique employee id" do
		@employee.save
		@employee_copy = Employee.new( :employee_id => "52", :name => "Ishank Gupta", :email => "ishank.gupta@vinsol.com" )
		@employee_copy.should_not be_valid
		@employee_copy.should have(1).error_on(:employee_id)
	end
	
	it "should have a name" do
		@employee.should validate_presence_of :name
	end
	
	it "should have many asset employee mappings" do
		@employee.should have_many :asset_employee_mappings
	end

	it "should have many assets" do
		@employee.should have_many :assets
	end
	
end	
