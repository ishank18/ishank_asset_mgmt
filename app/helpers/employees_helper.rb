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
		link_to 'Return Asset', return_asset_employee_mappings_path(:type => "employee", :id => employee.id.to_s) if assigned
	end		
	
	def show_history employee
		unless(employee.asset_employee_mappings.blank?)
			link_to "History", history_employee_path(employee)
		end
	end
	
	def show_disable_option emp_id
		if(Employee.only_deleted.where(:id => emp_id).blank?)
			link_to 'Disable', disable_employee_path(:id => emp_id), :method => :put
		end	
	end
	
end
