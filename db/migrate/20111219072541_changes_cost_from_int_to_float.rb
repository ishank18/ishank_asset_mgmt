class ChangesCostFromIntToFloat < ActiveRecord::Migration
  def self.up
  	change_table :assets do |t|
      t.change :cost, :float
    end
  end

  def self.down
  	change_table :assets do |t|
      t.change :cost, :integer
    end
  end
end
