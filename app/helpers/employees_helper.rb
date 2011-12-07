module EmployeesHelper
	def return_asset employee
		aem = AssetEmployeeMapping.where("employee_id = ?", employee.id)
		assigned = false
		unless(aem.empty?)
			aem.each do |a|
				if(a.asset.status == "Assigned")
					assigned = true
				end	
			end
		end
		link_to 'Return Asset', return_asset_path(employee) if assigned
	end		
end
