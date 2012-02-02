class ChangeAssignmmentTypeOfAem < ActiveRecord::Migration

  def self.up
  	Assignment.all.each do |aem|
			if(aem.assignment_type == "Permanent")
				@sql = "update asset_employee_mappings set assignment_type = '1' where id = '#{aem.id}'"
			else
				@sql = "update asset_employee_mappings set assignment_type = '0' where id = '#{aem.id}'"
			end
			execute(@sql) 
  	end
  	Assignment.reset_column_information
  	change_column :asset_employee_mappings, :assignment_type, :boolean
  end

  def self.down
  	change_column :asset_employee_mappings, :assignment_type, :string
  	Assignment.reset_column_information
  	Assignment.all.each do |aem|
			if(aem.assignment_type == "1")
				@sql = "update asset_employee_mappings set assignment_type = 'Permanent' where id = '#{aem.id}'"
			else
				@sql = "update asset_employee_mappings set assignment_type = 'Temporary' where id = '#{aem.id}'"
			end
			execute(@sql) 
  	end
  end
end
