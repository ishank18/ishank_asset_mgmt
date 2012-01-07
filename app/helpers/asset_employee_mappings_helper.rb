module AssetEmployeeMappingsHelper

	
	def get_employee aem
		if(!aem.employee.blank?)
			employee = aem.employee
		else
			employee = Employee.only_deleted.where(:id => aem.employee_id).first
		end	
	end
	
	def asset_name options_for_asset, f
		if(params[:type] == "employee")
			f.select :asset_id,  options_for_select(@options_for_asset), {}, :onchange => "changeForm();"
		else
			"#{f.hidden_field :asset_id} #{@aem.asset.name}".html_safe
		end		
	end
	
	

	
end
