class CreateMobilePhones < ActiveRecord::Migration
  def self.up
    create_table :mobile_phones do |t|
      t.string :operating_system

      t.timestamps
    end
  end

  def self.down
    drop_table :mobile_phones
  end
end
