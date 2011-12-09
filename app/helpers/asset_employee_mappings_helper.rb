module AssetEmployeeMappingsHelper
	def show_scheduled_date date_obj
		unless(date_obj.nil?)
			" Original Return Date : <b>#{date_to_string date_obj}</b>".html_safe
		end
	end
	
	def asset_name options_for_asset, f
		if(@return_type == "employee")
			f.select :asset_id,  options_for_select(options_for_asset), {}, :onchange => "changeForm();"
		else
			"#{f.hidden_field :asset_id} #{@aem.asset.name}".html_safe
		end		
	end
	
	def show_name aem
		if(params[:resource] == "asset")
			link_to aem.employee.name, aem.employee
		else
			link_to aem.asset.name, aem.asset
		end
	end
	
	def show_name_title
		if(params[:resource] == "asset")
			"Employee Name"
		else
			"Asset Name"
		end
	end
	
	def show_page_title
		if(params[:resource] == "asset")
			"History - #{Asset.where(:id => params[:id]).first.name}"
		else
			"History - #{Employee.where(:id => params[:id]).first.name}"
		end
	end
	
end
