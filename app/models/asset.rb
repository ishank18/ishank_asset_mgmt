class Asset < ActiveRecord::Base

  ### validates presens of purchase date  
  
	validates :name, :presence => true
	validates :status, :presence => true
	validates :cost, :presence => true, :numericality => true, :length => {:maximum => 10}
	validates :resource_type, :presence => true
	validates :serial_number, :presence => true, :uniqueness => true
	validates :purchase_date, :presence => true
	validates :vendor, :presence => true
	validate :check_future_date					
	
	belongs_to :resource, :polymorphic => true	
	has_and_belongs_to_many :tags, :join_table => 'assets_tags'  
  has_many :asset_employee_mappings
	has_many :employees, :through => :asset_employee_mappings
	
	
	def assigned_employee
		asset_employee_mappings.where(:status => "Assigned").first.employee 
	end
	
	def can_be_assigned?
		(status != "Assigned"	&& status != "repair")
	end
  
  def check_future_date
		unless(purchase_date.blank?)  
			if(purchase_date > Time.now)
					errors.add(:base, 'Future Purchase date is not allowed')
			end
		end
  end

  
end
