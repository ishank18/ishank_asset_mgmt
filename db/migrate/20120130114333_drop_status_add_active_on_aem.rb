class DropStatusAddActiveOnAem < ActiveRecord::Migration
  def self.up
  	add_column :asset_employee_mappings, :is_active, :boolean, :default => true
  	remove_column :asset_employee_mappings, :status
  end

  def self.down
  	remove_column :asset_employee_mappings, :is_active
  	add_column :asset_employee_mappings, :status, :string
  end
end
