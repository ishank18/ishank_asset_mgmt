module AssetsHelper
	def show_employee asset
		if(asset.asset_employee_mappings.empty?)
			"-"
		else
			link_to asset.asset_employee_mappings.first.employee.name, asset.asset_employee_mappings.first.employee
		end
		
	end
end
