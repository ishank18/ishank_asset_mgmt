module AssignmentsHelper

		
	def asset_name f
		if(params[:type] == "employee")
			f.select :asset_id, options_for_select(options_for_asset), {}, :onchange => "changeForm();"
		else
			"#{f.hidden_field :asset_id} #{@assignment.asset.name}".html_safe
		end		
	end
	
	def options_for_asset
		@assignments.collect { |assignment| ["#{assignment.asset.id} - #{assignment.asset.name}", assignment.asset_id] }
	end
	
	def fetch_assets
		Asset.assignable.collect { |asset| ["#{asset.id} - #{asset.name}", asset.id] }
	end	
	
end
