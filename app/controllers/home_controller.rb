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
		  @result = Asset.search(params[:search]).paginate(:page => params[:page], :per_page => 20)
    end  
	end
	
	## Will show assets in  the tags in the home page - Using AJAX
	def show_tag
		@tag = Tag.where(:id => params[:tag_id]).first
		@assets = @tag.assets
		render :partial => "/home/show_tags"
	end

end
