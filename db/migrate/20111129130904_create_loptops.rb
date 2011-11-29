class CreateLoptops < ActiveRecord::Migration
  def self.up
    create_table :loptops do |t|
      t.string :operating_system
      t.boolean :has_bag

      t.timestamps
    end
  end

  def self.down
    drop_table :loptops
  end
end
