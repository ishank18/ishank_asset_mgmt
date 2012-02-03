class HomeController < ApplicationController
		
	def index
		@tags = Tag.includes(:assets)
	end
	
	## Will search assets and employees and will filter it according to status and category
	def search
		@result = []
		asset, employee, status, category = params[:query_for_asset],  params[:query_for_emp], params[:status], params[:category]	
		if(asset.present? or category.present? or status.present?)		
			@result = Asset.where("assets.name like ?", "%#{asset}%")
			if(category.present?)
				@result = (@result.blank? ? Asset : @result).where("assets.type = ?", category) # Use send if required
			end
			if(status.present?)
				@result = (@result.blank? ? Asset : @result).where("assets.status = ?", status)
			end
			if(employee.present?)
				@result = @result.joins(:assignments).joins(:employees).where("employees.name like ? and asset_employee_mappings.date_returned is NULL", "%#{employee}%")
			end
		elsif(employee.present?)
			@result = Employee.where("employees.name like ?", "%#{employee}%")
		end
		@result = (@result.paginate :page => params[:page], :per_page => 2) unless @result.blank?
	end
	
	## Will show assets in  the tags in the home page - Using AJAX
	def show_tag
		@tag = Tag.where(:id => params[:tag_id]).first
		@assets = @tag.assets.paginate :page => params[:page], :order => 'created_at asc', :per_page => 2
	end
		
end
