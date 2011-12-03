class Employee < ActiveRecord::Base
	validates_presence_of :name, :email, :company_id
	has_many :asset_employee_mappings
end
