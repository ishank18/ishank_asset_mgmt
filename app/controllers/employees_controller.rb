class EmployeesController < ApplicationController
	
	before_filter :find_employee, :only => [:edit, :update, :disable]
	
  def index
 		@employees = Employee.try((params[:type]) ? :only_deleted : :scoped ).includes(:assignments).paginate :page => params[:page], :order => 'created_at asc', :per_page => 20
  	redirect_to root_path, :notice => "Could not find #{params[:type]} employees" if @employees.empty?
  end

  def show
  	@employee = Employee.with_deleted.where(:id => params[:id]).first
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
  
  # index action - Done
	
	def enable
		employee = Employee.only_deleted.where(:id => params[:id]).first
		if(employee.recover)
			redirect_to employee, :alert => "Employee Successfully Enabled!"
		else
			redirect_to disabled_employees_path, :alert => "This Employee cant be deleted!"
		end	
	end
	
	## Used to soft delete the employees, will not let them delete if any asset is assigned to them
	def disable
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
