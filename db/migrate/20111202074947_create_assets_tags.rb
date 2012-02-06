class CreateAssetsTags < ActiveRecord::Migration
  def self.up
  	create_table :assets_tags, {:id => false} do |t|
  		t.integer :asset_id
  		t.integer :tag_id
  	end
  end

  def self.down
  	drop_table :assets_tags
  end
end
