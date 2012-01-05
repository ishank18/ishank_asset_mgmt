class RenameComapanyIdEmployee < ActiveRecord::Migration
  def self.up
  	rename_column :employees, :company_id, :employee_id
  end

  def self.down
  	rename_column :employees, :employee_id, :company_id
  end
end
