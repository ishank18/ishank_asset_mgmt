class AssetEmployeeMapping < ActiveRecord::Base

	before_create :update_status
	before_update :update_aem_asset

	validates :date_issued, :presence => true
	validates :asset_id, :presence => true
	validates :employee_id, :presence => true
	
	validate :check_future_issued_date, :on => :create
	validate :temporarly_assignment_date, :on => :create
	validate :check_presence_of_date_returned, :on => :update
	validate :return_date_not_future, :on => :update
	validate :check_temp_assignment_date

	belongs_to :asset
	belongs_to :employee
	
	## Scope which will return assets which are assigned after checking Asset & AEM status
	scope :assigned_assets, lambda { 
		where(:status => "Assigned").
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
		self.status = STATUS["Assigned"]
		Asset.where(:id => asset_id).first.update_attributes(:status => STATUS["Assigned"])
	end
	
	## Update the assets and AEM status when an asset is returned
	def update_aem_asset
		self.status = "returned"
		asset.status = STATUS["Spare"]
		asset.save!
	end
	
	## Checks if the Issue date is not future
	def check_future_issued_date		
		if (!date_issued.blank?) && (date_issued > DateTime.now)
			errors.add(:date_issued, " can't be future date")
		end	
	end
	
	## Checks if the return date is not less than assigned date
	def check_temp_assignment_date
		if (!date_returned.blank? & !date_issued.blank?) && (date_issued > date_returned)
			errors.add(:base, "Date Returned can't be smaller than date issued")
		end	
	end
	
	## Checks the presence of return date of update action
	def check_presence_of_date_returned
		errors.add(:date_returned, " can't be blank") if date_returned.blank?
	end
	
	## Checks if the date_returned is not blank if assignment type is temporary
	def temporarly_assignment_date
		errors.add(:date_returned, " can't be blank on Temporarly Assignment") if assignment_type == "Temporary" && date_returned.blank?
	end
	
	## Checks if the return date is not future on update action
	def return_date_not_future
		if(!date_returned.blank?) && (date_returned > DateTime.now)
			errors.add(:date_returned, " can't be future date")
		end	
	end
	
end

