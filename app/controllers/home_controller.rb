class HomeController < ApplicationController
		
		def index
			p session
			@tags = Tag.all
		end
		
		  
		def search
			
		end
end
