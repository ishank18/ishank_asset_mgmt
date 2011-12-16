class AssetsController < ApplicationController
  
  def index
  	@assets = Asset.all
  end


  def show
  	@asset = Asset.where(:id => params[:id]).first
  end

	def history
		@aem = AssetEmployeeMapping.where(:asset_id => params[:id])
	end

  def new
  	@asset = Asset.new
  end
  
  def assign
  	@aem = AssetEmployeeMapping.new
  	@options_for_emp = get_all_employee
  end
  
  def create
		@asset = Asset.new(params[:asset])
		@asset.purchase_date = string_to_date params[:asset][:purchase_date]

		@asset.resource = params[:asset][:resource_type].classify.constantize.new(params[:resource])


		if(@asset.save)
			add_tags params['tagsTextField']
			redirect_to assets_path, :alert => "Asset Successfully Added!"
		else
			@category = params[:category]
			@asset.purchase_date = date_to_string @asset.purchase_date
			render :action => "new"
		end
			
	end	
  

  def edit
    ### extract below line in asset
  	@asset = Asset.where(:id => params[:id]).first
  	@asset.purchase_date = date_to_string @asset.purchase_date
  end


	def change_form_content
	  
	end


	def update
		@asset = Asset.where(:id => params[:id]).first
		params[:asset][:purchase_date] = string_to_date params[:asset][:purchase_date]
		
		if @asset.update_attributes(params[:asset])
			category = @asset.resource_type
			if(category == "Laptop")
				@asset.resource.update_attributes(:operating_system => params[:operating_system], :has_bag => params[:has_bag])
			elsif(category == "MobilePhone")
				@asset.resource.update_attributes(:operating_system => params[:operating_system])
			elsif(category == "NetworkDevice")
				@asset.resource.update_attributes(:location => params[:location])
			end

			add_tags params['tagsTextField']
			redirect_to @asset, :alert => "Asset Successfully updated"
		else
			@asset.purchase_date = date_to_string @asset.purchase_date
			render :action => "edit"
		end
	end
	
	

	def add_tags t
		tags = t.split(",")
		tags.each do |tag|
			if(tag_element = Tag.find_by_name(tag.strip))
				@asset.tags << tag_element
			else
				new_tag = Tag.create(:name => tag.strip)
				@asset.tags << new_tag				
			end	
		end	
	end



	def add_to_category params
		category = params[:category]
		
		
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
