class HomeController < ApplicationController
		
	def index
		@tags = Tag.includes(:assets)
	end
	
	## Optimize  
	def search
		@result = AssetEmployeeMapping.search params[:query_for_asset],  params[:query_for_emp], params[:status], params[:category]
		unless(@result.blank?)
			temp = []
			if(@result[0].class.name == "AssetEmployeeMapping")
				@result.each do |aem|
					temp << aem.asset
				end
				@result = temp.dup
			end
		end		
	end
	
	def show_tag
		@tag = Tag.where(:id => params[:tag_id]).first
	end
		
end
