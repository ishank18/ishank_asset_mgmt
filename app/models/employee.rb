class Employee < ActiveRecord::Base


	acts_as_paranoid
	
	validates :email, :presence => true, :uniqueness => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
	validates :employee_id, :presence => true, :numericality => {:only_integer => true, :greater_than => 0, :message => " employee Id must be positive"}, :uniqueness => true
	validates :name, :presence => true
	
  has_many :asset_employee_mappings
	has_many :assets, :through => :asset_employee_mappings
	
	def can_be_disabled?
		status_array = asset_employee_mappings.collect { |a| a.status }
		!status_array.include? STATUS["Assigned"]
	end
		
end
