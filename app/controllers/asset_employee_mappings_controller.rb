class AssetEmployeeMappingsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def new
  	@aem = AssetEmployeeMapping.new
  	@options_for_emp = get_all_employee
  end
  
  def populate_asset
  	@assets = Asset.where("resource_type = ? and status != 'Assigned'", params[:category])
  end

	def create
	
		aem_params = params[:asset_employee_mapping]
		@aem = AssetEmployeeMapping.new(aem_params)
		@aem.date_issued = DateTime.strptime(aem_params[:date_issued], "%m/%d/20%y") if(aem_params[:date_issued] != "")	
		@aem.date_returned = DateTime.strptime(aem_params[:date_returned], "%m/%d/20%y") if(aem_params[:date_returned] != "" && aem_params[:date_returned] != nil)
		@options_for_emp = get_all_employee
		if(@aem.save)
			Asset.update(aem_params[:asset_id], :status => "Assigned")
			redirect_to Employee.find(aem_params[:employee_id]), :alert => "Asset Successfully Assigned"
		else
			@aem.date_issued = aem_params[:date_issued].strftime("%m/%d/20%y") if(aem_params[:date_issued] != "")
			@aem.date_returned = aem_params[:date_returned].strftime("%m/%d/20%y") if(aem_params[:date_returned] != "" && aem_params[:date_returned] != nil)
			render :action => "new"
		end		
		
	end
	
	
	def get_all_employee
		options_for_emp = []
		Employee.all.each do |emp|
  		currOpt = []
  		currOpt << emp.name
  		currOpt << emp.id
  		options_for_emp << currOpt
  	end
  	options_for_emp
	end
	
end
