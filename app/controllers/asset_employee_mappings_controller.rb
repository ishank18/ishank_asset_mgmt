class AssetEmployeeMappingsController < ApplicationController

  def new
  	@aem = AssetEmployeeMapping.new
  end
  
	def create
	
		@aem = AssetEmployeeMapping.new(params[:asset_employee_mapping])
		cba = Asset.where(:id => params[:asset_employee_mapping][:asset_id]).first.try(:can_be_assigned?)
		if ((@aem.save) && cba)
      # Put in after_create
			redirect_to @aem.employee, :alert => "Asset Successfully Assigned"
		else
      # set datepicker's default date
			render :template => "assets/assign"
		end
	end
	
	def edit
  end
  
  
	def update
		
		@aem = AssetEmployeeMapping.where(:employee_id => params[:asset_employee_mapping][:employee_id], :asset_id => params[:asset_employee_mapping][:asset_id], :status => 'Assigned').first
		
	  # put in callback
		if(@aem.update_attributes(params[:asset_employee_mapping]))
			redirect_to employee_path(@aem.employee), :alert => "Asset Successfully Returned!"
		else
			render :action => :return_asset
		end
	end
	
	
	def return_asset
		if(params[:type].downcase == "employee")
			@aem_array = AssetEmployeeMapping.where(:employee_id => params[:id], :status => "Assigned")
		else
			@aem_array = AssetEmployeeMapping.where(:asset_id => params[:id], :status => "Assigned")
		end
		@aem = (@aem_array.select {|aem| aem if aem.asset.status == "Assigned" && aem.status = "Assigned"}).first
		
		# Put in view
	
		redirect_to assets_path, :alert => "No asset is assigned to selected pair" if @aem.blank?
	end
	
	
	def change_aem_form
		emp_id = params[:employee_id]
		ast_id = params[:asset_id]
		@aem = AssetEmployeeMapping.where(:asset_id => ast_id, :employee_id => emp_id, :status => "Assigned").first
		p @aem
	end
	
	
	def populate_asset
  	@assets = Asset.where("resource_type = ? and status != 'Assigned'", params[:category])
  end
	
end
