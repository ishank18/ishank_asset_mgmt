class CreateNetworkDevices < ActiveRecord::Migration
  def self.up
    create_table :network_devices do |t|
      t.string :location

      t.timestamps
    end
  end

  def self.down
    drop_table :network_devices
  end
end
