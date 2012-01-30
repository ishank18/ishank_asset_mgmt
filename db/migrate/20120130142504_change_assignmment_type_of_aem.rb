class ChangeAssignmmentTypeOfAem < ActiveRecord::Migration
  def self.up
  	change_column :asset_employee_mappings, :assignment_type, :boolean
  end

  def self.down
  	change_column :asset_employee_mappings, :assignment_type, :string
  end
end
