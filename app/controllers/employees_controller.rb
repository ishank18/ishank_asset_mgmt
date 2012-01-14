class EmployeesController < ApplicationController
	
	before_filter :find_employee, :only => [ :edit, :update]
	
  def index
  	@employees = Employee.includes(:asset_employee_mappings)
  	redirect_to root_path, :alert => "Disabled Employee list is empty!" if @employees.blank?
  end

  def show
  	@employee = Employee.where(:id => params[:id]).first
  	if(@employee.nil?)
  		@employee = Employee.only_deleted.where(:id => params[:id]).first
  	end	
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

  def edit
  end

	def update
		if @employee.update_attributes(params[:employee])
			redirect_to(@employee, :alert => 'Employee details successfully updated.')
		else
			render :action => "edit"
		end
	end
	
	
	## Will show the asset history of the Employee
	def history
		@aem = (AssetEmployeeMapping.where :employee_id => params[:id]).order "status asc"
	end

	def disabled
  	@employees = Employee.only_deleted
  	redirect_to root_path, :alert => "Disabled Employee list is empty!" if @employees.blank?
	end
	
	def enable
		
		employee = Employee.only_deleted.where(:id => params[:id]).first
		if(employee.recover)
			redirect_to employee, :alert => "Employee Successfully Enabled!"
		else
			redirect_to disabled_employees_path, :alert => "This Employee cant be deleted!"
		end	
	end
	
	# Move to before_destroy
	## Used to soft delete the employees, will not let them delete if any asset is assigned to them
	def disable
	
		@employee = Employee.where(:id => params[:id]).first
		unless @employee.can_be_disabled?
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
