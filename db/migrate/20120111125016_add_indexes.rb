class AddIndexes < ActiveRecord::Migration
  def self.up
  	add_index :assets, :name
  	add_index :employees, :name
  end

  def self.down
  	remove_index :assets, :column => :name
  	remove_index :assets, :column => :name
  end
end
