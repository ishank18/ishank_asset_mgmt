module AssetsHelper

	def show_employee asset
	  
    # if asset.status == "Assigned"
    #       link_to asset.employees.first.name, asset.asset_employee_mappings.first.employee
    # else
    #   "-"
    # end 
	  
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
		if !asset.new_record?
			asset.resource_type
		else
<<<<<<< HEAD
			select_tag "category", options_for_select(CATEGORY, @category || ""), :include_blank => "- Select -", :onchange => "changeForm()"	
=======
			select_tag "category", options_for_select(CATEGORY, params[:category] || ""), :include_blank => "- Select -", :onchange => "changeForm()"	
>>>>>>> ffd953e85c040ad123e052b9d686eaec41d01dd2
		end
	end
	
	def render_specific_partial rt
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
