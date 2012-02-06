class RemoveAemComments < ActiveRecord::Migration
  def self.up
		remove_column :asset_employee_mappings, :remark
  end

  def self.down
  	add_column :asset_employee_mappings, :remark, :string
  end
end
