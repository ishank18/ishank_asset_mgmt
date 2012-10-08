class HomeController < ApplicationController
		
	def index
		@tags = Tag.includes(:assets)
		@assets = Asset.limit(5)
		@employees = Employee.limit(5)
		@assignments = Assignment.limit(5)
	end
	
	## Will search assets and employees and will filter it according to status and category
	def search
		if request.xhr?
  		asset, employee, status, category = params[:asset],  params[:employee], params[:status], params[:category]	
  		if(asset.present? or category.present? or status.present?)
  			@result = Asset.search asset, status, category, employee
  		elsif(employee.present?)
  			@result = Employee.where("employees.name like ?", "%#{employee}%")
  		end
  		@result = @result.paginate :page => params[:page], :per_page => 5
    end  
	end
	
	## Will show assets in  the tags in the home page - Using AJAX
	def show_tag
		@tag = Tag.where(:id => params[:tag_id]).first
		@assets = @tag.assets.paginate :page => params[:page], :order => 'created_at asc', :per_page => 5
	end

end
