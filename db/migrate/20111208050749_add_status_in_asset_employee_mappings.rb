class AddStatusInAssetEmployeeMappings < ActiveRecord::Migration
  def self.up
  	add_column :asset_employee_mappings, :status, :string
  end

  def self.down
  	drop_column :asset_employee_mappings, :status
  end
end
