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
		@aem = AssetEmployeeMapping.where(:asset_id => params[:id]).order 'status asc'
	end

  def new
  	@asset = Asset.new
  end
  
  def assign
  	@aem = AssetEmployeeMapping.new
  end
  
  def create
		@asset = Asset.new params[:asset]
		if(@asset.save)
			#add_tags params[:tagsTextField]
			redirect_to assets_path, :alert => "Asset Successfully Added!"
		else
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
			#add_tags params['tagsTextField']
			redirect_to @asset, :alert => "Asset Successfully updated"
		else
			render :action => "edit"
		end
	end
	
	
	protected
	
	def find_asset
	  @asset = Asset.where(:id => params[:id]).first
	  redirect_to root_path, :notice => "Could not find asset" unless @asset
	end
	
	
end
