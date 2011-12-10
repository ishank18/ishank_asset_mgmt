class AddDeletedAtToEmployees < ActiveRecord::Migration
  def self.up
  	add_column :employees, :deleted_at, :datetime
  end

  def self.down
  	remove_column :employees, :deleted_at
  end
end
