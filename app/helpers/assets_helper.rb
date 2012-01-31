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
				status_wo_recieved = STATUS.dup
				status_wo_recieved.delete("Recieved")
				f.select(:status, options_for_select(status_wo_recieved.to_a[0...status_wo_recieved.length-1], @asset.status), :include_blank => "- Select -")
			else
				f.select(:status, options_for_select(STATUS.to_a[0...STATUS.length-1], @asset.status), :include_blank => "- Select -")
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
		Asset.where(%{resource_type = ? and status not in ('#{STATUS["Assigned"]}', '#{STATUS["Repair"]}')}, params[:category]).each do |asset|
				currOpt = []
				currOpt << "#{asset.id} - #{asset.name}"
				currOpt << asset.id
				options << currOpt
		end
		options
	end	
		
end
