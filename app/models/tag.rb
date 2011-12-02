class Tag < ActiveRecord::Base
	has_and_belongs_to_many :assets, :join_table => 'assets_tags'
end
