class Asset < ActiveRecord::Base

  ### validates presens of purchase date  
  
	validates :name, :presence => true
	validates :status, :presence => true
	validates :cost, :allow_nil => true, :numericality => true, :length => {:maximum => 10}
	
	
	belongs_to :resource, :polymorphic => true	
	has_and_belongs_to_many :tags, :join_table => 'assets_tags'  
  has_many :asset_employee_mappings
	has_many :employees, :through => :asset_employee_mappings
	accepts_nested_attributes_for :resource
	
	
	def assigned_employee
		asset_employee_mappings.where(:status => "Assigned").first.employee 
	end
	
	def can_be_assigned?
		(status != "Assigned"	&& status != "repair")
	end
  
end
