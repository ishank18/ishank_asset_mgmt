class AssignmentsController < ApplicationController
  
  def new
  	@assignment = Assignment.new
  end
  
	def create
		@assignment = Assignment.new(params[:assignment])
		if (@assignment.save)
			redirect_to @assignment.employee, :alert => "Asset Successfully Assigned"
		else
			render :action => 'new'
		end
	end
  

	def return_asset
		if(params[:type].downcase == "employee")
			@assignment_array = Assignment.where(:employee_id => params[:id]).assigned_assets
		else
			@assignment_array = Assignment.where(:asset_id => params[:id]).assigned_assets
		end

		@assignment = @assignment_array.first
		redirect_to assets_path, :alert => "No asset is assigned to selected pair" if @assignment.blank?
	end


	def update
    # Use id to find 
		@assignment = Assignment.where(:employee_id => params[:assignment][:employee_id], 
		:asset_id => params[:assignment][:asset_id], :date_returned => nil).first
		
		if(@assignment.update_attributes(params[:assignment]))
			redirect_to employee_path(@assignment.employee), :alert => "Asset Successfully Returned!"
		else
			render :action => :return_asset
		end
	end
	
	
	## Will change the return form according to the selected asset to be returned - Using AJAX
	def change_aem_form
		@assignment = Assignment.where(:asset_id => params[:asset_id], :employee_id => params[:employee_id], :date_returned => nil).first
	end
	
	## Will populate the select box according to the category of asset and when the status is not assigned - Using AJAX
	def populate_asset
  	@assets = Asset.can_be_assigned_from_category params[:category]
  end
	
end
