class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :name
      t.string :status
      t.integer :cost
      t.string :serial_number
      t.datetime :purchase_date
      t.text :additional_info
      t.text :description
      t.integer :resource_id
      t.string :resource_type
			
      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
