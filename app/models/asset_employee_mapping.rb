class AssetEmployeeMapping < ActiveRecord::Base

	before_create :update_status
	before_create :check_future_issued_date
	before_save :check_temp_assignment_date
	before_update :update_aem_asset

	validates :date_issued, :presence => true
	validates :asset_id, :presence => true
	validates :employee_id, :presence => true


	belongs_to :asset
	belongs_to :employee

	## Used to search assets and employees, will also filter the result wrt status and category
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
				id, name from employees where name like "%#{employee_str}%" AND (employees.deleted_at IS NULL)
			}
			Employee.find_by_sql(sql)
		else
			[]
		end
	end
	
	## Used to update status of AEM and assets when a new asset is assigned
	def update_status
		self.status = "Assigned"
		Asset.where(:id => self.asset_id).first.update_attributes(:status => "Assigned")
	end
	
	## Checks if the Issue date is not future
	def check_future_issued_date		
		if self.date_issued > DateTime.now
			errors.add(:base, "Issue date can't be future date")
			return false
		end
	end
	
	## Checks if the return date is not less than assigned date
	def check_temp_assignment_date
		unless(self.date_returned.blank?)
			if(self.date_issued > self.date_returned)
				errors.add(:base, 'Date Returned Cant be greater than date issued')
				return false
			end
		end	
	end
	
	## Update the assets and AEM status when an asset is returned
	def update_aem_asset
		self.status = "returned"
		self.asset.status = "spare"
		self.asset.save!
	end
	
end

