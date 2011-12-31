class Employee < ActiveRecord::Base


	acts_as_paranoid
	
  ### Add validations for checking email format, uniqueness, 
  ### numericality, positivity and uniqueness of employee id,
  ### uniqueness of name 
  #validate :positive_emp_id
	
	### Do in rails 3 way ex - validates :name, :presence => true, :uniqueness => true
	validates :email, :presence => true, :uniqueness => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
	validates :company_id, :presence => true, :numericality => {:only_integer => true, :greater_than => 0, :message => " employee Id must be positive"}, :uniqueness => true
	validates :name, :presence => true
	
  #### Use has many through
  
  has_many :asset_employee_mappings
	has_many :assets, :through => :asset_employee_mappings
	
end
