module EmployeesHelper

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
