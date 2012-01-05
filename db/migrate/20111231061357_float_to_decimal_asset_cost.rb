class FloatToDecimalAssetCost < ActiveRecord::Migration
  def self.up
  	change_table :assets do |t|
      t.change :cost, :decimal, :precision => 12, :scale => 2

    end
  end

  def self.down
  	change_table :assets do |t|
      t.change :cost, :float
    end
  end
end
