module HistoriesHelper
	def show_employee history
		emp = (history.employee) ? history.employee : Employee.with_deleted.where(:id => history.employee_id).first
		link_to emp.name, employee_path(emp.id)
	end
end
