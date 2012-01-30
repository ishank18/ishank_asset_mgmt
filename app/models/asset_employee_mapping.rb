# status shoud be boolean and default value true

class AssetEmployeeMapping < ActiveRecord::Base

	after_create :update_status
	after_update :update_aem_asset

	validates :asset_id, :presence => true
	validates :employee_id, :presence => true
	validates :date_returned, :on => :update, :presence => true
	validates :date_issued, :presence => true, :date => { :before => Proc.new { Time.zone.now } }, :allow_blank => true
	validates :date_returned, :on => :update, :date => { :before => Proc.new { Time.zone.now } }, :allow_blank => true
	validates :date_returned, :date => { :after => :date_issued }, :allow_blank => true
	
	validate :temporarly_assignment_date, :on => :create
	
	belongs_to :asset
	belongs_to :employee
	
	## Scope which will return assets which are assigned after checking Asset & AEM status
	scope :assigned_assets, lambda { 
		where(:is_active => true).
		joins(:asset).
		where("assets.status = ?", STATUS["Assigned"]).
		includes(:asset)
	}		 
	
	## Used to search assets and employees, will also filter the result wrt status and category
	def self.search asset_str, employee_str, status, category
		sql = "SELECT"
		if((!asset_str.blank? or !status.blank? or !category.blank?) && !employee_str.blank?)
			sql += %{
				distinct(asset_employee_mappings.id), asset_employee_mappings.asset_id FROM `asset_employee_mappings` 
				INNER JOIN `assets` ON `assets`.`id` = `asset_employee_mappings`.`asset_id` 
				INNER JOIN `employees` ON `employees`.`id` = `asset_employee_mappings`.`employee_id` 
				where assets.name like '%#{asset_str}%' and employees.name like '%#{employee_str}%'
				and asset_employee_mappings.status = '#{STATUS["Assigned"]}'
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
			AssetEmployeeMapping.find_by_sql(sql).collect {|aem| aem.asset}
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
    # asset.update_attributes(:status => STATUS["Assigned"]) - Use relation - Done
		asset.update_attributes(:status => STATUS["Assigned"])
	end
	
	## Update the assets and AEM status when an asset is returned
	## after_update
	def update_aem_asset
    # status should be false - Done
    # use update_attributes - Done
		asset.update_attributes(:status => STATUS["Spare"])
	end

	## Checks if the date_returned is not blank if assignment type is temporary
	def temporarly_assignment_date
		errors.add(:date_returned, " can't be blank on Temporarly Assignment") if assignment_type == "Temporary" && date_returned.blank?
	end
	
end

