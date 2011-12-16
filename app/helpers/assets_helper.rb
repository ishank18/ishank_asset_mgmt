module AssetsHelper

	def show_employee asset
    # Fetch calue from constant
		if(asset.status == "Assigned")
			link_to asset.assigned_employee.name, asset.assigned_employee
		else
			"-"	
		end

	end
	
	def show_asset_history asset
		unless(asset.asset_employee_mappings.blank?)
			link_to "History", history_asset_employee_mappings_path(:resource => "asset", :id => asset.id)
		end
	end
	
	def show_status asset
		if(asset.status == "Assigned")
			"Assigned to #{link_to asset.assigned_employee.name, asset.assigned_employee}".html_safe
		else
			asset.status.capitalize
		end
	end
	
	
	def show_category asset
		if !asset.new_record?
			asset.resource_type
		else
			select_tag "category", options_for_select(CATEGORY, params[:category] || ""), :include_blank => "- Select -", :onchange => "changeForm()"	
		end
	end
	
	
	def render_specific_partial rt
		#render :partial => rt
		if(rt == "Laptop")
			render :partial => "laptop"
		elsif(rt == "NetworkDevice")
			render :partial => "network_device"
		elsif(rt == "MobilePhone")
			render :partial => "mobile_phone"
		end	
	end
	
	def tag_class tag
		tag_count = tag.assets.count
		if(tag_count == 1)
			"TagSizeOne TagSpan"
		elsif(tag_count == 2)
			"TagSizeTwo TagSpan"
		elsif(tag_count == 3)
			"TagSizeThree TagSpan"
		elsif(tag_count == 4)
			"TagSizeFour TagSpan"
		else			
			"TagSizeBig TagSpan"
		end	
	end
	
end
