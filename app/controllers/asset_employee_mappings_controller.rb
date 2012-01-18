class AssetEmployeeMappingsController < ApplicationController

  def new
  	@aem = AssetEmployeeMapping.new
  end
  
	def create
	
		@aem = AssetEmployeeMapping.new(params[:asset_employee_mapping])
		can_be_assigned = Asset.where(:id => params[:asset_employee_mapping][:asset_id]).first.try(:can_be_assigned?)
		
		if (@aem.save && can_be_assigned)
      # Put in after_create
			redirect_to @aem.employee, :alert => "Asset Successfully Assigned"
		else
      # set datepicker's default date
			#flash[:alert] = "This asset can not be assigned right now" unless can_be_assigned
			render :template => "assets/assign"
		end
	end
	
	def edit
  end
  
  
	def update
		
		@aem = AssetEmployeeMapping.where(:employee_id => params[:asset_employee_mapping][:employee_id], 
		:asset_id => params[:asset_employee_mapping][:asset_id], :status => STATUS["Assigned"]).first
		
	  # put in callback
		if(@aem.update_attributes(params[:asset_employee_mapping]))
			redirect_to employee_path(@aem.employee), :alert => "Asset Successfully Returned!"
		else
			render :action => :return_asset
		end
	end
	
	## Will render the return asset form
	def return_asset
		if(params[:type].downcase == "employee")
			@aem_array = AssetEmployeeMapping.where(:employee_id => params[:id], :status => STATUS["Assigned"]).joins(:asset).where("assets.status = ?", STATUS["Assigned"])
		else
			@aem_array = AssetEmployeeMapping.where(:asset_id => params[:id], :status => STATUS["Assigned"]).joins(:asset).where("assets.status = ?", STATUS["Assigned"])
		end
		## Put above
		@aem = @aem_array.first
		# Put in view
		redirect_to assets_path, :alert => "No asset is assigned to selected pair" if @aem.blank?
	end
	
	## Will change the return form according to the selected asset to be returned - Using AJAX
	def change_aem_form
		@aem = AssetEmployeeMapping.where(:asset_id => params[:asset_id], :employee_id => params[:employee_id], :status => STATUS["Assigned"]).first
	end
	
	## Will populate the select box according to the category of asset and when the status is not assigned - Using AJAX
	def populate_asset
  	@assets = Asset.where(%{resource_type = ? and status not in ('#{STATUS["Assigned"]}', '#{STATUS["Repair"]}')}, params[:category])
  end
	
end
