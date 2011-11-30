class RenameLoptops < ActiveRecord::Migration
  def self.up
  	rename_table :loptops, :laptops
  end

  def self.down
  	rename_table :laptops, :loptops
  end
end
