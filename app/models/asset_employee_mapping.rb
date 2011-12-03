class AssetEmployeeMapping < ActiveRecord::Base
	belongs_to :asset
	belongs_to :employee
end
