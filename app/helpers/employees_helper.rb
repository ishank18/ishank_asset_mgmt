module EmployeesHelper

	def show_history employee
		unless(employee.assignments.blank?)
			link_to "History", history_employee_path(employee)
		end
	end
	
	def show_disable_option emp
	  unless emp.deleted?
		  link_to 'Disable', disable_employee_path(emp.id), :method => :put, :class => "btn btn-small btn-warning"
		else
		  link_to 'Enable', enable_employee_path(emp.id), :method => :put, :class => "btn btn-small"
		end
	end
	
end
