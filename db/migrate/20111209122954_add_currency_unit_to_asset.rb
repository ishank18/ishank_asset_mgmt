class AddCurrencyUnitToAsset < ActiveRecord::Migration
  def self.up
    	add_column :assets, :currency_unit, :string
  end

  def self.down
    	remove_column :assets, :currency_unit
  end
end
