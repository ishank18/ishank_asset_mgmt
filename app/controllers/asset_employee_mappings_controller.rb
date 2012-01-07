class AssetEmployeeMappingsController < ApplicationController

  def new
  	@aem = AssetEmployeeMapping.new
  end
  
	def create
	
		@aem = AssetEmployeeMapping.new(params[:asset_employee_mapping])
		
		if(@aem.save && Asset.where(:id => params[:asset_employee_mapping][:asset_id]).first.try(:can_be_assigned?))
      # Put in after_create
			redirect_to @aem.employee, :alert => "Asset Successfully Assigned"
		else
      # set datepicker's default date
			render :action => "assets/assign"
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
			aem_array = AssetEmployeeMapping.where(:employee_id => params[:id])
		else
			aem_array = AssetEmployeeMapping.where(:asset_id => params[:id], :status => "Assigned")
		end
		
		@options_for_asset = []

		# Put in view
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
		@aem = AssetEmployeeMapping.where(:asset_id => ast_id, :employee_id => emp_id).first
	end
	
	
	def populate_asset
  	@assets = Asset.where("resource_type = ? and status != 'Assigned'", params[:category])
  end
	
end
