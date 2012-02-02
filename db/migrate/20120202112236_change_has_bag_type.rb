class ChangeHasBagType < ActiveRecord::Migration
  def self.up
  	change_column :assets, :has_bag, :boolean
  end

  def self.down
  	change_column :assets, :has_bag, :integer
  end
end
