class AssetEmployeeMappingsController < ApplicationController

  def new
  	@aem = AssetEmployeeMapping.new
  end
  
	def create
	
		@aem = AssetEmployeeMapping.new(params[:asset_employee_mapping])
		can_be_assigned = Asset.where(:id => params[:asset_employee_mapping][:asset_id]).first.try(:can_be_assigned?)
		
		if (can_be_assigned && @aem.save)
      # Put in after_create
			redirect_to @aem.employee, :alert => "Asset Successfully Assigned"
		else
      # set datepicker's default date
			flash[:alert] = "This asset can not be assigned right now" unless can_be_assigned
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
			@aem_array = AssetEmployeeMapping.where(:employee_id => params[:id], :status => "Assigned").joins(:asset).where("assets.status = ?", "Assigned")
		else
			@aem_array = AssetEmployeeMapping.where(:asset_id => params[:id], :status => "Assigned").joins(:asset).where("assets.status = ?", "Assigned")
		end
		
		## Put above
		@aem = @aem_array.first
		
		# Put in view
	
		redirect_to assets_path, :alert => "No asset is assigned to selected pair" if @aem.blank?
	end
	
	
	def change_aem_form
		@aem = AssetEmployeeMapping.where(:asset_id => params[:asset_id], :employee_id => params[:employee_id], :status => "Assigned").first
	end
	
	
	def populate_asset
  	@assets = Asset.where("resource_type = ? and status != 'Assigned'", params[:category])
  end
	
end
