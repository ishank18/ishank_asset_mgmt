class AssignmentsController < ApplicationController
  
  def new
  	@assignment = Assignment.new
  	@assignment.build_comment
  end
  
	def create
		@assignment = Assignment.new(params[:assignment])
		if (@assignment.save)
			redirect_to @assignment.employee, :alert => "Asset Successfully Assigned"
		else
			@assignment.build_comment unless @assignment.comment
			render :action => 'new'
		end
	end
  

	def return_asset
		if(params[:type].downcase == "employee")
			@assignments = Assignment.where(:employee_id => params[:id]).assigned_assets.includes(:asset)
		else
			@assignments = Assignment.where(:asset_id => params[:id]).assigned_assets.includes(:asset)
		end
		@assignment = @assignments.first
		@assignment.build_comment unless @assignment.comment
		redirect_to assets_path, :alert => "No asset is assigned to selected pair" if @assignment.blank?
	end


	def update
		@assignment = Assignment.where(:id => params[:id]).first
		
		if(@assignment.update_attributes(params[:assignment]))
			redirect_to employee_path(@assignment.employee), :alert => "Asset Successfully Returned!"
		else
			@assignment.build_comment unless @assignment.comment
			render :action => 'return_asset'
		end
	end
	
	
	## Will change the return form according to the selected asset to be returned - Using AJAX
	def change_aem_form
		@assignment = Assignment.where(:asset_id => params[:asset_id], :employee_id => params[:employee_id], :date_returned => nil).first
	end
	
	## Will populate the select box according to the category of asset and when the status is not assigned - Using AJAX
	def populate_asset
  	@assets = params[:category].constantize.assignable
  end
	
end
