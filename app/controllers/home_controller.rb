class HomeController < ApplicationController
		
	def index
		@tags = Tag.includes(:assets)
	end
	
	## Will search assets and employees and will filter it according to status and category
	## Optimize
	def search
		asset, employee, status, category = params[:query_for_asset],  params[:query_for_emp], params[:status], params[:category]	
		if(asset.present? or category.present? or status.present?)		
			@result = Asset.where("assets.name like ?", "%#{asset}%")
			if(category.present?)
				if(@result.blank?)
					@result = Asset.where("assets.resource_type = ?", category)
				else
					@result = @result.where("assets.resource_type = ?", category)
				end
			end
			if(status.present?)
				if(@result.blank?)
					@result = Asset.where("assets.status = ?", status)
				else
					@result = @result.where("assets.status = ?", status)
				end
			end
			if(employee.present?)
				@result = @result.joins(:assignments).joins(:employees).where("employees.name like ? and asset_employee_mappings.is_active = '1'", "%#{employee}%")
			end
		elsif(employee.present?)
			@result = Employee.where("employees.name like ?", "%#{employee}%")

		else
			@result = []	
		end
		
		
		
#		if((!asset.blank? or !status.blank? or !category.blank?) && !employee.blank?)
#			@record = Assignment.joins(:asset).joins(:employee).where("assets.name like ? and employees.name like ? and asset_employee_mappings.is_active = '1'", "%#{asset}%", "%#{employee}%")
#			unless status.blank?
#				@record = @record.where("assets.status = ?", status)
#			end	
#			unless category.blank?
#				@record = @record.where("assets.resource_type = ?", category)
#			end
#			@result = @record.collect { |aem| aem.asset }
#			
#		end
		#@result = Assignment.search params[:query_for_asset],  params[:query_for_emp], params[:status], params[:category]		
	end
	
	## Will show assets in  the tags in the home page - Using AJAX
	def show_tag
		@tag = Tag.where(:id => params[:tag_id]).first
		@assets = @tag.assets.paginate :page => params[:page], :order => 'created_at asc', :per_page => 2
	end
		
end
