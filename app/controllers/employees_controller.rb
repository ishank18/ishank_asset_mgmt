class EmployeesController < ApplicationController
	
	before_filter :find_employee, :only => [:show, :edit, :update]
	
  def index
  	@employees ||= Employee.includes(:asset_employee_mappings) 
  end

  def show
  	if(@employee.nil?)
  		@employee = Employee.only_deleted.where(:id => params[:id]).first
  	end	
  end

	def history
		@aem = (AssetEmployeeMapping.where :employee_id => params[:id]).order "status asc"
	end

	def disabled
  	@employees = Employee.only_deleted	
  	render :action => "index"
	end

  def edit
  end

  def new
  	@employee = Employee.new
  end

	def create
		@employee = Employee.new(params[:employee])
		if(@employee.save)
			redirect_to employees_path, :alert => "Asset Successfully Added!"
		else
			render :action => "new"	
		end		
	end

	def update
		if @employee.update_attributes(params[:employee])
			redirect_to(@employee, :alert => 'Employee details successfully updated.')
		else
			render :action => "edit"
		end
	end
	
	## Used to solf delete the employees, will not let them delete if any asset is assigned to them
	def disable
		aem = Employee.where(:id => params[:id]).first.asset_employee_mappings.collect { |a| a.status }
		
		if(aem.include?("Assigned"))
			redirect_to :back, :notice => "First remove all assigned Asset"
		else
			Employee.where(:id => params[:id]).first.destroy	
			redirect_to employees_path, :notice => "Employee Successfully disable"			
		end
	end
	
	protected
	
	def find_employee
	  @employee = Employee.where(:id => params[:id]).first
	  redirect_to root_path, :notice => "Could not find employee" unless @employee
	end
	
	
end
