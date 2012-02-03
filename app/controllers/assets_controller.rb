class AssetsController < ApplicationController
  
  before_filter :find_asset, :only => [:show, :edit, :update, :destroy]
  
  def index
  	@assets = Asset.includes(:assignments).paginate :page => params[:page], :order => 'created_at asc', :per_page => 20
 		redirect_to root_path, :notice => "Could not find assets, first add new asset" if @assets.empty?
  end

  def show
  end

  def new
  	@asset = Asset.new
  end
  
  def create
		@asset = params[:asset][:type].constantize.new params[:asset]
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
