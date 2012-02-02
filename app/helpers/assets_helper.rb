module AssetsHelper

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
	
	def show_category asset, f, type
		unless asset.new_record?
			params[:type].tableize.humanize
		else
			f.select(:type, options_for_select(CATEGORY, type), :include_blank => "- Select -")
		end
	end

		
end
