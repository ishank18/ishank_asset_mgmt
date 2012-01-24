class AssetsController < ApplicationController
  
  before_filter :find_asset, :only => [:show, :edit, :update, :destroy]
  
  ## created_at desc
  def index
  	@assets = Asset.includes(:asset_employee_mappings).paginate :page => params[:page], :order => 'created_at asc', :per_page => 20
 		redirect_to root_path, :notice => "Could not find assets, first add new asset" if @assets.empty?
  end

  ## Move in before_filter - Done
  ## redirect somewhere if asset not found - Done
  def show
  end
	
	## Will show the employee history of the Asset 
	def history
		@aem = AssetEmployeeMapping.where(:asset_id => params[:id]).includes(:employee)
	end

  def new
  	@asset = Asset.new
  end
  
  ## Will render the asset assignment form 
  def assign
  	@aem = AssetEmployeeMapping.new
  end
  
  def create
		@asset = Asset.new params[:asset]
		if(@asset.save)
			redirect_to @asset, :alert => "Asset Successfully Added!"
		else
			render :action => "new"
		end			
	end	
  
  def edit
  end

	## Will change the new asset form wrt the category selected
	def change_form_content  
	end

	def update
		if @asset.update_attributes(params[:asset])
		  ## Should clubbed with params[:asset]	 - Done
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
