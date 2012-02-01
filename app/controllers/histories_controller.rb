class HistoriesController < ApplicationController
	def index
		if(params[:type] == "employee")
		  @employee = Employee.with_deleted.where(:employee_id => params[:id]).first
			@histories = @employee.asset_employee_mappings.includes(:asset)
		else
			@histories = AssetEmployeeMapping.where(:asset_id => params[:id]).includes(:asset)
		end	
	end
end
