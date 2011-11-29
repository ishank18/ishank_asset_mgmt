class CreateAssetEmployeeMappings < ActiveRecord::Migration
  def self.up
    create_table :asset_employee_mappings do |t|
      t.integer :asset_id
      t.integer :employee_id
      t.datetime :date_issued
      t.datetime :date_returned
      t.text :remark

      t.timestamps
    end
  end

  def self.down
    drop_table :asset_employee_mappings
  end
end
