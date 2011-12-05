class HomeController < ApplicationController
		
		def index
			@tags = Tag.all
		end
		
		  
		def search
			
		end
end
