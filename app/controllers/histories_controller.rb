class HistoriesController < ApplicationController
	def index
		if(params[:type] == "employee")
			@histories = AssetEmployeeMapping.where(:asset_id => params[:id]).includes(:employee)
		else
			@histories = AssetEmployeeMapping.where(:asset_id => params[:id]).includes(:asset)
		end	
	end
end
