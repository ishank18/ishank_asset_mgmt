class Employee < ActiveRecord::Base


	acts_as_paranoid
	
	validates :email, :presence => true, :uniqueness => true
	validates :email, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }, :allow_blank => true
	validates :employee_id, :presence => {:message => 'Id cannot be blank'}, :uniqueness => { :message => "Id has already being taken" }
	validates :employee_id, :numericality => { :only_integer => true, :greater_than => 0, :message => " Id must be positive"}, :allow_blank => true
	validates :name, :presence => true
	
  has_many :assignments
	has_many :assets, :through => :assignments
	
	def can_be_disabled?
		status_array = assignments.collect { |a| a.is_active }
		!status_array.any?
	end
		
end
