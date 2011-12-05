class Employee < ActiveRecord::Base

  ### Add validations for checking email format, uniqueness, 
  ### numericality, positivity and uniqueness of employee id,
  ### uniqueness of name 

	validates_presence_of :name, :email, :company_id
	has_many :asset_employee_mappings
end
