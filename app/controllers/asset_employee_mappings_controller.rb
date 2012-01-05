class AssetEmployeeMappingsController < ApplicationController

  ## Move to asset as assign -> collection
  def new
  	@aem = AssetEmployeeMapping.new
  end
  
	def create
		aem_params = params[:asset_employee_mapping]
		asset = Asset.where(:id => aem_params[:asset_id]).first
		cba = asset.try(:can_be_assigned?)
		@aem = AssetEmployeeMapping.new(aem_params)
		@aem.date_issued = string_to_date aem_params[:date_issued]
		@aem.date_returned = string_to_date aem_params[:date_returned]
		if(@aem.save && cba)
			asset.update_attributes(:status => "Assigned")
			redirect_to Employee.find(aem_params[:employee_id]), :alert => "Asset Successfully Assigned"
		else
			@aem.date_issued = aem_params[:date_issued]
			@aem.date_returned = aem_params[:date_returned]
			render :action => "new"
		end		
	end
	
	def edit
  end
  
	def update
		
		@aem = AssetEmployeeMapping.where(:employee_id => params[:asset_employee_mapping][:employee_id], :asset_id => params[:asset_employee_mapping][:asset_id], :status => 'Assigned').first
		@aem.date_returned = string_to_date params[:return_date]
		@aem.status = "returned"
		@aem.asset.status = "spare"
		@aem.asset.save!
	
		if(@aem.update_attributes(params[:asset_employee_mapping]))
			redirect_to employee_path(@aem.employee), :alert => "Asset Successfully Returned!"
		else
			render :action => return_asset
		end
	end
	
	
	def return_asset
		@return_type = params[:type]
		if(@return_type == "employee")
			aem_array = AssetEmployeeMapping.where(:employee_id => params[:id])
		else
			aem_array = AssetEmployeeMapping.where(:asset_id => params[:id], :status => "Assigned")
		end
		
		@options_for_asset = []
		aem_array.each do |aem|
			if(aem.asset.status == "Assigned" && aem.status == "Assigned")
				@aem ||= aem
				currOpt = []
				currOpt << aem.asset.name
				currOpt << aem.asset_id
				@options_for_asset << currOpt
			end	
		end
		redirect_to assets_path, :alert => "No asset is assigned to selected pair" if @aem.blank?
	end
	
	
	def change_aem_form
		emp_id = params[:employee_id]
		ast_id = params[:asset_id]
		@aem = AssetEmployeeMapping.where("asset_id = ? and employee_id = ?", ast_id, emp_id).first
	end
	

	
	
	def populate_asset
  	@assets = Asset.where("resource_type = ? and status != 'Assigned'", params[:category])
  end
	
end
