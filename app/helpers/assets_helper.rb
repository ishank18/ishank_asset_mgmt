module AssetsHelper

  ## Move in view - (Done)
	
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
			select_tag "asset[resource_type]", options_for_select(CATEGORY, @asset.resource_type), :include_blank => "- Select -", :onchange => "changeForm()"	
		end
	end
	
	

	
end
