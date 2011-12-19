class AssetEmployeeMappingsController < ApplicationController

  
	def create

		@asset = Asset.where(:id => params[:asset_employee_mapping][:asset_id]).first
		cba = @asset.try(:can_be_assigned?)

		@aem = AssetEmployeeMapping.new(params[:asset_employee_mapping])
		@aem.date_issued = string_to_date params[:asset_employee_mapping][:date_issued]
		@aem.date_returned = string_to_date params[:asset_employee_mapping][:date_returned]

    ## put in before_create
		@aem.status = "Assigned"

    ## Put in view
		@options_for_emp = get_all_employee

		if(@aem.save && cba)
      # Put in after_create
			asset.update_attributes(:status => "Assigned")
			redirect_to @aem.employee, :alert => "Asset Successfully Assigned"
		else
      # set datepicker's default date
      @aem.date_issued = params[:asset_employee_mapping][:date_issued]
      @aem.date_returned = params[:asset_employee_mapping][:date_returned]
			render :action => "new"
		end		
	end
	
	def edit
  end
  
  
	def update
		
		@aem = AssetEmployeeMapping.where(:employee_id => params[:asset_employee_mapping][:employee_id], :asset_id => params[:asset_employee_mapping][:asset_id], :status => 'Assigned').first
		@aem.date_returned = string_to_date params[:return_date]
		
	  # put in callback
		@aem.asset.status = "spare"
	
		if @aem.update_attributes((params[:asset_employee_mapping]).merge!( {:asset_employee_mapping => {:status => "return"}} ))
			redirect_to employee_path(@aem.employee), :alert => "Asset Successfully Returned!"
		else
			render :action => return_asset
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
		@aem = AssetEmployeeMapping.where("asset_id = ? and employee_id = ?", ast_id, emp_id).first
	end
	

	
	
	def populate_asset
  	@assets = Asset.where("resource_type = ? and status != 'Assigned'", params[:category])
  end
	
end
