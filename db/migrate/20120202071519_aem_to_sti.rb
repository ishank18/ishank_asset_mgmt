class AemToSti < ActiveRecord::Migration
  def self.up
  	add_column :assets, :type, :string
  	add_column :assets, :operating_system, :string
  	add_column :assets, :location, :string
  	add_column :assets, :has_bag, :integer
  	Asset.all.each do |asset|
  		sql = ""
  		type = asset.resource.class.name
  		if(type == "Laptop")
  			sql = "update assets set operating_system = '#{asset.resource.operating_system}', has_bag = '#{asset.resource.has_bag ? 1 : 0 }', type = '#{type}' where id = '#{asset.id}'"
  		elsif(type == "MobilePhone")
  			sql = "update assets set operating_system = '#{asset.resource.operating_system}', type = '#{type}' where id = '#{asset.id}'"
  		else
  			sql = "update assets set location = '#{asset.resource.location}', type = '#{type}' where id = '#{asset.id}'"
  		end
  		execute(sql)
  	end
  	remove_column :assets, :resource_id
  	remove_column :assets, :resource_type
  	drop_table :laptops
  	drop_table :network_devices
  	drop_table :mobile_phones
  end

  def self.down
#  	add_column :assets, :resource_id, :integer
#  	add_column :assets, :resource_type, :string
#    create_table :loptops do |t|
#      t.string :operating_system
#      t.boolean :has_bag
#      t.timestamps
#    end  	
#    create_table :mobile_phones do |t|
#      t.string :operating_system
#      t.timestamps
#    end
#    create_table :network_devices do |t|
#      t.string :location
#      t.timestamps
#    end
#    
##    Asset.all.each do |asset|
##    	sql = ""
##    	if(asset.type == "Laptop")
##    		sql = "insert into laptops set operating_system = '{asset.operating_system}', has_bag = '{asset.resource.has_bag ? 1 : 0 }'"
##    		
##			elsif(asset.type == "MobilePhone")
##				mp = MobilePhone.create(:operating_system => asset.operating_system, :has_bag => asset.has_bag)
##    end
    
    
  end
end
