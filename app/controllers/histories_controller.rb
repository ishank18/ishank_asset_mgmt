class HistoriesController < ApplicationController
	def index
		if(params[:type] == "employee")
		  @record = Employee.with_deleted.where(:id => params[:id]).first
		else
			@record = Asset.where(:id => params[:id]).first
		end	
    @histories = @record.assignments.includes(params[:type] == 'employee' ? :asset : :employee)
		
	end
end