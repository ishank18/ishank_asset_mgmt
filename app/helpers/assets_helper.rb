module AssetsHelper

	def show_employee asset
		if(asset.asset_employee_mappings.empty?)
			"-"
		else
			if(asset.status == "Assigned")
				link_to asset.asset_employee_mappings.first.employee.name, asset.asset_employee_mappings.first.employee
			else
				"-"	
			end
		end
	end
	
	def show_status asset
		if(asset.status == "Assigned")
			"Assigned to #{link_to asset.asset_employee_mappings.first.employee.name, asset.asset_employee_mappings.first.employee}".html_safe
		else
			asset.status
		end
	end
	
	def show_category asset
		if(asset.id)
			asset.resource_type
		else
			select_tag "category", options_for_select(CATEGORY, @category), :include_blank => "- Select -", :onchange => "changeForm()"	
		end
	end
	
	def render_specific_partial rt
		if(rt == "Laptop")
			render :partial => "laptop"
		elsif(rt == "NetworkDevice")
			render :partial => "network_device"
		elsif(rt == "MobilePhone")
			render :partial => "mobile_phone"
		else		
		end	
	end
	
	
	
end
