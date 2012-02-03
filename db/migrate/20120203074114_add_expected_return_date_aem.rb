class AddExpectedReturnDateAem < ActiveRecord::Migration
  def self.up
  	add_column :asset_employee_mappings, :expected_return_date, :datetime
  	remove_column :asset_employee_mappings, :assignment_type
  	remove_column :asset_employee_mappings, :is_active
  end

  def self.down
		add_column :asset_employee_mappings, :assignment_type, :boolean
  	add_column :asset_employee_mappings, :is_active, :boolean
  	remove_column :asset_employee_mappings, :expected_return_date
  end
end
