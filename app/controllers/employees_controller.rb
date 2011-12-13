class EmployeesController < ApplicationController
	
  def index
  	@employees ||= Employee.all 
  end

  def show
  	@employee = Employee.where(:id => params[:id]).first
  	if(@employee.nil?)
  		@employee = Employee.only_deleted.where(:id => params[:id]).first
  	end	
  end

	def disabled
  	@employees = Employee.only_deleted	
  	render :action => "index"
	end

  def edit
  	@employee = Employee.where(:id => params[:id]).first
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
		@employee = Employee.where(:id => params[:id]).first
		if @employee.update_attributes(params[:employee])
			redirect_to(@employee, :alert => 'Employee details successfully updated.')
		else
			render :action => "edit"
		end
	end
	
	def disable
		#employee = Employee.where(:id => params[:id]).first
		Employee.where(:id => params[:id]).first.destroy	
		redirect_to employees_path, :notice => "Employee Successfully disable"
	end
	
	
	

end
