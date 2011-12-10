class AddVendorToAsset < ActiveRecord::Migration
  def self.up
  	add_column :assets, :vendor, :string
  end

  def self.down
  	remove_column :assets, :vendor
  end
end
