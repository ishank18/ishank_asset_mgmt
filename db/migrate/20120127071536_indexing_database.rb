class IndexingDatabase < ActiveRecord::Migration
  def self.up
  	add_index :asset_employee_mappings, :employee_id
  	add_index :asset_employee_mappings, :asset_id
  	add_index :assets_tags, :asset_id
  	add_index :assets_tags, :tag_id
  	add_index :assets, [:resource_id, :resource_type]
  end

  def self.down
  	remove_index :asset_employee_mappings, :employee_id
  	remove_index :asset_employee_mappings, :asset_id
  	remove_index :assets_tags, :asset_id
  	remove_index :assets_tags, :tag_id
  	remove_index :assets, [:resource_id, :resource_type]
  end
end
