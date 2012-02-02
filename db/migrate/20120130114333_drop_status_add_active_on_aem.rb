class DropStatusAddActiveOnAem < ActiveRecord::Migration
  def self.up
  	add_column :asset_employee_mappings, :is_active, :boolean, :default => true
  	Assignment.reset_column_information
  	Assignment.all.each do |aem|
			if(aem.status == "Assigned")
				@sql = "update asset_employee_mappings set is_active = '1' where id = '#{aem.id}'"
			else
				@sql = "update asset_employee_mappings set is_active = '0' where id = '#{aem.id}'"
			end
			execute(@sql) 
  	end  	
  	remove_column :asset_employee_mappings, :status
  end

  def self.down
		add_column :asset_employee_mappings, :status, :string
		
  	Assignment.reset_column_information
  	Assignment.all.each do |aem|
			if(aem.is_active)
				@sql = "update asset_employee_mappings set status = 'Assigned' where id = '#{aem.id}'"
			else
				@sql = "update asset_employee_mappings set status = 'returned' where id = '#{aem.id}'"
			end
			execute(@sql) 
  	end
  	remove_column :asset_employee_mappings, :is_active
  	
  end
end
