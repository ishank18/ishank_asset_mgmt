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
    # at view level
  	@options_for_emp = get_all_employee
  end
  
  def create
		@asset = Asset.new(params[:asset])
		@asset.purchase_date = string_to_date params[:asset][:purchase_date]
		
		resource_type = params[:asset][:resource_type]
		@asset.resource = resource_type.classify.constantize.new(params[:resource]) unless resource_type.blank?
		
		if(@asset.save)
			add_tags params[:tagsTextField]
			redirect_to assets_path, :alert => "Asset Successfully Added!"
		else
			@category = resource_type
			@asset.purchase_date = date_to_string @asset.purchase_date
			render :action => "new"
		end			
	end	
  
  def edit
    ### extract below line in find_asset before_filter
  	@asset = Asset.where(:id => params[:id]).first
  	@asset.purchase_date = date_to_string @asset.purchase_date
  end

	def change_form_content  
	end

	def update
		@asset = Asset.where(:id => params[:id]).first
		params[:asset][:purchase_date] = string_to_date params[:asset][:purchase_date]
		
		if @asset.update_attributes(params[:asset])
			@asset.resource.update_attributes(params[:resource])
			add_tags params['tagsTextField']
			redirect_to @asset, :alert => "Asset Successfully updated"
		else
			@asset.purchase_date = params[:asset][:purchase_date]
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
	
end
