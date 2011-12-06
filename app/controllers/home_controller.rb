class HomeController < ApplicationController
		
		def index
			@tags = Tag.all
		end
		
		  
		def search
			@query_for_asset = params[:query_for_asset]
			@query_for_emp = params[:query_for_emp]
			
			@result = []
		end
		
end
