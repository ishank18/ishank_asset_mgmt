module EmployeesHelper
	def return_asset employee
		aem = AssetEmployeeMapping.where(:employee_id => employee.id)
		assigned = false
		unless(aem.empty?)
			aem.each do |a|
				if(a.status == "Assigned")
					assigned = true
				end	
			end
		end
		link_to 'Return Asset', return_asset_path(:type => "employee", :id => employee.id.to_s) if assigned
	end		
	
	def show_history employee
		unless(employee.asset_employee_mappings.blank?)
			link_to "History", show_history_path(:resource => "employee", :id => employee.id.to_s)
		end
	end
	
end
