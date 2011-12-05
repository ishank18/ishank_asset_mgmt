class AssetsController < ApplicationController
  
  def index
  	@assets = Asset.all
  end

  def show
  	
  end

  def edit
  	@asset = Asset.where("id = ?", params[:id]).first
  	@asset.purchase_date = @asset.purchase_date.strftime("%m/%d/20%y") if (@asset.purchase_date != "" && @asset.purchase_date != nil)
  end

  def new
  	@asset = Asset.new
  	@category = ""
  end

	def change_form_content
		@sp_asset = params[:category]
	end
	
	def create
    ### Cannot change params

		@category = params[:category]
		@asset = Asset.new(params[:asset])
		@asset.purchase_date = DateTime.strptime(params[:asset][:purchase_date], "%m/%d/20%y") unless(params[:asset][:purchase_date] == "")
		if(@category == "laptop")
			@laptop = Laptop.new(:operating_system => params[:operating_system], :has_bag => params[:has_bag])
			@asset.resource = @laptop
		
		elsif(@category == "mobile_phone")
			@mobile_phone = MobilePhone.new(:operating_system => params[:operating_system])
			@asset.resource = @mobile_phone	
		
		elsif(@category == "network_device")
			@network_device = NetworkDevice.new(:location => params[:location])
			@asset.resource = @network_device
		else
		end	

		if(@asset.save)
			tags = params['tagsTextField'].split(",")
			tags.each do |tag|
				if(tag_element = Tag.find_by_name(tag.strip))
					@asset.tags << tag_element
					
				else
					new_tag = Tag.create(:name => tag.strip)
					@asset.tags << new_tag				
				end	
			end	
			redirect_to assets_path, :alert => "Asset Successfully Added!"
		else
			@category = params[:category]
			@asset.purchase_date = @asset.purchase_date.strftime("%m/%d/20%y") unless(params[:asset][:purchase_date] == "")
			render :action => "new"
		end	
	end	

end
