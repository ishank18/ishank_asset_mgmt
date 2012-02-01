module AssignmentsHelper

	
	def get_employee assignment
		if(!assignment.employee.blank?)
			employee = assignment.employee
		else
			employee = Employee.only_deleted.where(:id => assignment.employee_id).first
		end	
	end
	
	def asset_name f
		if(params[:type] == "employee")
			f.select :asset_id, options_for_select(options_for_asset), {}, :onchange => "changeForm();"
		else
			"#{f.hidden_field :asset_id} #{@assignment.asset.name}".html_safe
		end		
	end
	
	def options_for_asset
		options = []
		@assignment_array.each do |assignment|
				options << ["#{assignment.asset.id} - #{assignment.asset.name}", assignment.asset_id]
		end
		options
	end
	

	
end
