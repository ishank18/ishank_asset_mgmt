class EmployeesController < ApplicationController
  def index
  	@employees = Employee.all
  end

  def show
  end

  def edit
  	@employee = Employee.where("id = ?", params[:id]).first
  end

  def new
  	@employee = Employee.new
  end

	def create
		@employee = Employee.new(params[:employee])
		if(@employee.save)
			redirect_to employees_path, :alert => "Asset Successfully Added!"
		else
			render :partial => "form"	
		end		
	end

	def update
		@employee = Employee.where("id = ?", params[:id]).first
		if @employee.update_attributes(params[:employee])
			redirect_to(@employee, :alert => 'Employee details successfully updated.')
		else
			render :action => "edit"
		end
	end

end
