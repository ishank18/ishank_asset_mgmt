class HistoriesController < ApplicationController
	def index
		if(params[:type] == "employee")
			@histories = AssetEmployeeMapping.where(:employee_id => params[:id]).includes(:asset).includes(:employee)
		else
			@histories = AssetEmployeeMapping.where(:asset_id => params[:id]).includes(:asset).includes(:employee)
		end	
	end
end
