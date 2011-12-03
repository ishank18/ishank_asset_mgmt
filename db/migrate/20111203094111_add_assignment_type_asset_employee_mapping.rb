class AddAssignmentTypeAssetEmployeeMapping < ActiveRecord::Migration
  def self.up
  	add_column :asset_employee_mappings, :assignment_type, :string
  end

  def self.down
  	drop_column :asset_employee_mappings, :assignment_type
  end
end
