class Employee < ActiveRecord::Base

  ### Add validations for checking email format, uniqueness, 
  ### numericality, positivity and uniqueness of employee id,
  ### uniqueness of name 
  validate :positive_emp_id
	
	### Do in rails 3 way ex - validates :name, :presence => true, :uniqueness => true
	validates :email, :presence => true, :uniqueness => true
	
	
	
	validates_uniqueness_of :company_id, :email
	validates_numericality_of :company_id
	validates_presence_of :name, :email, :company_id
	
  #### Use has many through
  
  has_many :asset_employee_mappings
	has_many :assets, :through => :asset_employee_mappings
	
  # define_index do
  #   indexes :name
  # end
	
	## Add in validation
	def positive_emp_id
		errors.add(:company_id, "should be a positive value") if (company_id.nil? || company_id < 0.01)
	end
end
