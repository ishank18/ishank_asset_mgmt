class HomeController < ApplicationController
		
	def index
		@tags = Tag.includes(:assets)
	end
	
	## Will search assets and employees and will filter it according to status and category
  # Optimize
	def search
    asset, employee, status, category = params[:asset],  params[:employee], params[:status], params[:category]	
		
		if(asset.present? or category.present? or status.present?)		
			
			@result = Asset.where("assets.name like ?", "%#{asset}%") #if asset.present?
			@result = (@result.blank? ? Asset : @result).where("assets.type = ?", category) #if category.present?
			@result = (@result.blank? ? Asset : @result).where("assets.status = ?", status) #if status.present?
			@result = @result.joins(:assignments => :employee).where("employees.name like ? and asset_employee_mappings.date_returned is NULL", "%#{employee}%") #if employee.present?
			
		elsif(employee.present?)
		
			@result = Employee.where("employees.name like ?", "%#{employee}%")
			
		end
		@result = (@result.paginate :page => params[:page], :per_page => 2) || []
	end
	
	## Will show assets in  the tags in the home page - Using AJAX
	def show_tag
		@tag = Tag.where(:id => params[:tag_id]).first
		@assets = @tag.assets.paginate :page => params[:page], :order => 'created_at asc', :per_page => 2
	end
		
end
