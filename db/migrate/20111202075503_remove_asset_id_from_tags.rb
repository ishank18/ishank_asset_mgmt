class RemoveAssetIdFromTags < ActiveRecord::Migration
  def self.up
  	add_column :tags, :description, :string
  	remove_column :tags, :asset_id
  end

  def self.down
  	add_column :tags, :asset_id, :integer
  	remove_column :tags, :description
  end
end
