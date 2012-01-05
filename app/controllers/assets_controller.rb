class AssetsController < ApplicationController
  
  before_filter :find_asset, :only => [:show, :edit, :update, :destroy]
  
  ## created_at desc
  def index
  	@assets = Asset.paginate :page => params[:page], :order => 'id asc', :per_page => 20
  end

  ## Move in before_filter
  ## redirect somewhere if asset not found
  def show
    
  end

	def history
		@aem = AssetEmployeeMapping.where(:asset_id => params[:id])
	end

  def new
  	@asset = Asset.new
  end
  
  def assign
  	@aem = AssetEmployeeMapping.new
  end
  
  def create
		@asset = Asset.new(params[:asset])
		
		resource_type = params[:asset][:resource_type]
		@asset.resource = resource_type.classify.constantize.new(params[:resource]) unless resource_type.blank?
		
		if(@asset.save)
			add_tags params[:tagsTextField]
			redirect_to assets_path, :alert => "Asset Successfully Added!"
		else
			@category = resource_type
			render :action => "new"
		end			
	end	
  
  def edit
  end

	def change_form_content  
	end

	def update
		if @asset.update_attributes(params[:asset])
		  ## Should clubbed with params[:asset]
      @asset.resource.update_attributes(params[:resource])
						
			add_tags params['tagsTextField']
			redirect_to @asset, :alert => "Asset Successfully updated"

		else
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
	
	protected
	
	def find_asset
	  @asset = Asset.where(:id => params[:id]).first
	  redirect_to root_path, :notice => "Could not find asset" unless @asset
	end
	
	
end
