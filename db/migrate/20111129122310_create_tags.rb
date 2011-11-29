class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.integer :asset_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
