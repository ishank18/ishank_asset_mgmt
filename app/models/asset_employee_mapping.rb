class AssetEmployeeMapping < ActiveRecord::Base
	belongs_to :asset
	belongs_to :employee
	validates_presence_of :date_issued, :asset_id, :employee_id
	
end
