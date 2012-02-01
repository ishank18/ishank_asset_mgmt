class HomeController < ApplicationController
		
	def index
		@tags = Tag.includes(:assets)
	end
	
	## Will search assets and employees and will filter it according to status and category
	def search
		@result = Assignment.search params[:query_for_asset],  params[:query_for_emp], params[:status], params[:category]		
	end
	
	## Will show assets in  the tags in the home page - Using AJAX
	def show_tag
		@tag = Tag.where(:id => params[:tag_id]).first
	end
		
end
