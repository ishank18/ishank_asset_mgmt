class AssetEmployeeMappingsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def new
  	@aem = AssetEmployeeMapping.new
  	@options_for_emp = get_all_employee
  end
  
  def populate_asset
  	@assets = Asset.where("resource_type = ? and status != 'Assigned'", params[:category])
  end

	def create
	
		aem_params = params[:asset_employee_mapping]
		@aem = AssetEmployeeMapping.new(aem_params)
		@aem.date_issued = string_to_date aem_params[:date_issued]
		@aem.date_returned = string_to_date aem_params[:date_returned]
		@options_for_emp = get_all_employee
		if(@aem.save)
			Asset.update(aem_params[:asset_id], :status => "Assigned")
			redirect_to Employee.find(aem_params[:employee_id]), :alert => "Asset Successfully Assigned"
		else
			@aem.date_issued = aem_params[:date_issued]
			@aem.date_returned = aem_params[:date_returned]
			render :action => "new"
		end		
		
	end
	
	def update
		@aem = AssetEmployeeMapping.where("employee_id = ? and asset_id = ?", params[:asset_employee_mapping][:employee_id], params[:asset_employee_mapping][:asset_id]).first
		@aem.date_returned = string_to_date params[:return_date]
		@aem.asset.status = "spare"
		@aem.asset.save!
		if(@aem.update_attributes(params[:asset_employee_mapping]))
			redirect_to employee_path(@aem.employee), :alert => "Asset Successfully Returned!"
		else
			render :action => return_asset
		end
	end
	
	def return_asset
		aem_array = AssetEmployeeMapping.where("employee_id = ?", params[:employee_id])
		#@aem = aem_array.first
		@options_for_asset = []
		aem_array.each do |aem|
			if(aem.asset.status == "Assigned")
				@aem ||= aem
				currOpt = []
				currOpt << aem.asset.name
				currOpt << aem.asset_id
				@options_for_asset << currOpt
			end	
		end
	end
	
	def change_aem_form
		emp_id = params[:employee_id]
		ast_id = params[:asset_id]
		@aem = AssetEmployeeMapping.where("asset_id = ? and employee_id = ?", ast_id, emp_id).first
	end
	
	def get_all_employee
		options_for_emp = []
		Employee.all.each do |emp|
  		currOpt = []
  		currOpt << emp.name
  		currOpt << emp.id
  		options_for_emp << currOpt
  	end
  	options_for_emp
	end
	
end
