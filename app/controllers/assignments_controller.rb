class AssignmentsController < ApplicationController
  
  def new
  	@assignment = Assignment.new
  end
  
	def create
		@assignment = Assignment.new(params[:assignment])

		can_be_assigned = Asset.where(:id => params[:assignment][:asset_id]).first.try(:can_be_assigned?)
		
		if (@assignment.save && can_be_assigned)
			redirect_to @assignment.employee, :alert => "Asset Successfully Assigned"
		else
      # set datepicker's default date - Done
			render :action => 'new'
		end
	end
  
	def update
		
		@assignment = Assignment.where(:employee_id => params[:assignment][:employee_id], 
		:asset_id => params[:assignment][:asset_id], :is_active => true).first
		
	  # put in callback - Done
		if(@assignment.update_attributes(params[:assignment]))
			redirect_to employee_path(@assignment.employee), :alert => "Asset Successfully Returned!"
		else
			render :action => :return_asset
		end
	end
	
	## Will render the return asset form
	def return_asset
		if(params[:type].downcase == "employee")
			@assignment_array = Assignment.where(:employee_id => params[:id]).assigned_assets
		else
			@assignment_array = Assignment.where(:asset_id => params[:id]).assigned_assets
		end
		## Put above - Done
		@assignment = @assignment_array.first
		# Put in view -Done
		redirect_to assets_path, :alert => "No asset is assigned to selected pair" if @assignment.blank?
	end
	
	## Will change the return form according to the selected asset to be returned - Using AJAX
	def change_aem_form
		@assignment = Assignment.where(:asset_id => params[:asset_id], :employee_id => params[:employee_id], :is_active => true).first
	end
	
	## Will populate the select box according to the category of asset and when the status is not assigned - Using AJAX
	def populate_asset
  	@assets = Asset.can_be_assigned_from_category params[:category]
  end
	
end
