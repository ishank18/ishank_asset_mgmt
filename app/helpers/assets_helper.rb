module AssetsHelper

  ## Move in view - (Done)
	
	def show_status asset
		if(asset.status == "Assigned")
			"Assigned to #{link_to asset.assigned_employee.name, asset.assigned_employee}".html_safe
		else
			asset.status.capitalize
		end
	end
	
	def show_status_field f
		if @asset.status == "Assigned"
			"Assigned"
		else 
			if @asset.new_record?
				f.select(:status, options_for_select(STATUS.to_a - [["Recieved", "recieved"], ["Assigned", "Assigned"]], @asset.status), :include_blank => "- Select -")
			else
				f.select(:status, options_for_select(STATUS.to_a - [["Assigned", "Assigned"]], @asset.status), :include_blank => "- Select -")
			end
		end
	end
	
	def show_category asset
		if !asset.new_record?
			asset.resource_type
		else
			select_tag "asset[resource_type]", options_for_select(CATEGORY, @asset.resource_type), :include_blank => "- Select -", :onchange => "changeForm()"	
		end
	end

	def fetch_assets
		options = []
		Asset.can_be_assigned(params[:category]).each do |asset|
				options << ["#{asset.id} - #{asset.name}", asset.id]
		end
		options
	end	
		
end
