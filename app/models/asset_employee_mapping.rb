class AssetEmployeeMapping < ActiveRecord::Base
	belongs_to :asset
	belongs_to :employee
	
	validates_presence_of :date_issued, :asset_id, :employee_id
	
	
	
	def self.search asset_str, employee_str, status, category
		sql = "SELECT"
		if((!asset_str.blank? or !status.blank? or !category.blank?) && !employee_str.blank?)
			sql += %{
				distinct(asset_employee_mappings.id), asset_employee_mappings.asset_id FROM `asset_employee_mappings` 
				INNER JOIN `assets` ON `assets`.`id` = `asset_employee_mappings`.`asset_id` 
				INNER JOIN `employees` ON `employees`.`id` = `asset_employee_mappings`.`employee_id` 
				where assets.name like '%#{asset_str}%' and employees.name like '%#{employee_str}%'
				and asset_employee_mappings.status = 'Assigned'
			}
			unless status.blank?
				sql += %{
					and assets.status = '#{status}'
				}
			end	
			unless category.blank?
				sql += %{
					and assets.resource_type = '#{category}'
				}
			end	
			AssetEmployeeMapping.find_by_sql(sql)
		elsif(!asset_str.blank? or !status.blank? or !category.blank?)
			sql += %{
				id, name from assets where name like "%#{asset_str}%"
			}
			unless status.blank?
				sql += %{
					and assets.status = '#{status}'
				}
			end	
			unless category.blank?
				sql += %{
					and assets.resource_type = '#{category}'
				}
			end	
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
