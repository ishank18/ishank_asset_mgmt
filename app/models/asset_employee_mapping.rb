class AssetEmployeeMapping < ActiveRecord::Base
	belongs_to :asset
	belongs_to :employee
	
	validates_presence_of :date_issued, :asset_id, :employee_id
	
	
	
	def self.search asset_str, employee_str
		sql = "SELECT"
		if(!asset_str.blank? && !employee_str.blank?)
			sql += %{
				distinct(asset_employee_mappings.id), asset_employee_mappings.asset_id FROM `asset_employee_mappings` 
				INNER JOIN `assets` ON `assets`.`id` = `asset_employee_mappings`.`asset_id` 
				INNER JOIN `employees` ON `employees`.`id` = `asset_employee_mappings`.`employee_id` 
				where assets.name like '%#{asset_str}%' and employees.name like '%#{employee_str}%'
				and asset_employee_mappings.status = 'Assigned'
			}
			AssetEmployeeMapping.find_by_sql(sql)
		elsif(!asset_str.blank?)
			sql += %{
				id, name from assets where name like "%#{asset_str}%"
			}
			Asset.find_by_sql(sql)
		elsif(!employee_str.blank?)
			sql += %{
				id, name from employees where name like "%#{employee_str}%"
			}
			Employee.find_by_sql(sql)
		else
			[]
		end
	end
	
end
