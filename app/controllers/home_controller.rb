class HomeController < ApplicationController
		
	def index
		@tags = Tag.all
	end
	
	  
	def search
		@query_for_asset = params[:query_for_asset]
		@query_for_emp = params[:query_for_emp]
		@result = AssetEmployeeMapping.search @query_for_asset, @query_for_emp
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
