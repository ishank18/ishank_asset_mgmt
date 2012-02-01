class HistoriesController < ApplicationController
	def index
		if(params[:type] == "employee")
		  @employee = Employee.with_deleted.where(:id => params[:id]).first
			@histories = @employee.assignments.includes(:asset)
		else
			@asset = Asset.where(:id => params[:id]).first
			@histories = @asset.assignments.includes(:employee)
		end	
	end
end
