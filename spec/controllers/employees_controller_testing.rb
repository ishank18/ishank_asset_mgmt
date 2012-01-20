require 'spec_helper'

describe EmployeesController do
  render_views
  
  before do
  	@employee = mock_model(Employee, :save => true, :employee_id => 53, :name => "Ishank Gupta", :email => "ishank_18@yahoooo.com")
  	@employees = [@employee]
  	@valid_attributes = {:employee_id => 53, :name => "Ishank Gupta", :email => "ishank_18@yahoooo.com"}
  	
		@admin = mock_model(Admin, :save => true, :email => "admin@example.com", :password => "password", :password_confirmation => "password")
		@aem = mock_model(AssetEmployeeMapping, :save => true, :employee_id => 4, :asset_id => 1, :date_returned => DateTime.now, :remark => "assign")
		@aems = [@aem]
		controller.stub!(:current_admin).and_return(@admin)
		controller.stub!(:authenticate_admin!).and_return(@admin)
  end
  
  
  describe "INDEX" do
  	describe "when has employees" do
		  it "get request should be successful" do
		  	
		    Employee.should_receive(:includes).and_return(@employees)
		    @employee.stub!(:deleted?).and_return(false)
		    @employee.should_receive(:asset_employee_mappings).and_return(@aems)
		    
		    get :index
		    
		    response.should be_success
		    response.should render_template("index")
		  end
		end 
  end

	describe "SHOW" do
		it "assigns the requested article as @employee & request should be successful" do
		
			employee = Employee.create! @valid_attributes
			
			get :show, :id => employee.id
			assigns(:employee).should eq(employee)
			
			response.should be_success
	    response.should render_template("show")
		end
	end
	
	describe "NEW" do
		it "assigns a new employee as @employee" do
		
    	get :new
    	assigns(:employee).should be_a_new(Employee)
    	
    	response.should be_success
	    response.should render_template("new")
    end
	end
	
  describe "EDIT" do
    it "assigns the requested employee as @employee" do
    
      employee = Employee.create! @valid_attributes
      
      get :edit, :id => employee.id
      assigns(:employee).should eq(employee)
      
      response.should be_success
	    response.should render_template("edit")
    end
  end
  
	describe "CREATE" do
    it "assigns a newly created employee as @employee" do
    
      post :create, :employee => @valid_attributes
      
      assigns(:employee).should be_a(Employee)
      assigns(:employee).should be_persisted
      
      response.should redirect_to(employees_path)
    end
    
    
	end
  
end  
