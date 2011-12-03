class AssetEmployeeMappingsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def new
  	@asset_employee_mapping = AssetEmployeeMapping.new
  	@options_for_emp = []
  	Employee.all.each do |emp|
  		currOpt = []
  		currOpt << emp.name
  		currOpt << emp.id
  		@options_for_emp << currOpt
  	end	
  end
  
  def populate_asset
  	@assets = Asset.where("resource_type = ? and status != 'Assigned'", params[:category])
  end

	def create
	
		aem_params = params[:asset_employee_mapping]
		aem_params[:date_issued] = DateTime.strptime(aem_params[:date_issued], "%m/%d/20%y")
		
		if(aem_params[:date_returned])
			aem_params[:date_returned] = DateTime.strptime(aem_params[:date_returned], "%m/%d/20%y")
		end	
		
		@aem = AssetEmployeeMapping.new(aem_params)
		
		if(@aem.save)
			Asset.update(aem_params[:asset_id], :status => "Assigned")
			redirect_to Employee.find(aem_params[:employee_id]), :alert => "Asset Successfully Assigned"
		else
			render "form"
		end		
		
	end

end
