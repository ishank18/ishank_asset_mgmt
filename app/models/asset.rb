class Asset < ActiveRecord::Base

  ### validates presens of purchase date
  
  def can_be_assigned?
		(self.status != "Assigned"	&& self.status != "repair")
	end
  
  
	belongs_to :resource, :polymorphic => true
	validates :category, :presence => true
	validates :name, :presence => true
	validates :status, :presence => true
	validates :cost, :allow_nil => true, :numericality => true, :length => {:maximum => 10}
	
	
	
	has_and_belongs_to_many :tags, :join_table => 'assets_tags'
  
  ## Use has many through for asset ans employees through asset_employee_mappings
  has_many :asset_employee_mappings
	has_many :employees, :through => :asset_employee_mappings
	
	def assigned_employee
		asset_employee_mappings.where(:status => "Assigned").first.employee 
	end
	
end
