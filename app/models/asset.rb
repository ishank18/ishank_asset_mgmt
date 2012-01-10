class Asset < ActiveRecord::Base

  ### validates presens of purchase date  
  before_save :change_tags_to_array
  
	validates :name, :presence => true
	validates :status, :presence => true
	validates :resource_type, :presence => true
	validates :cost, :presence => true, :numericality => true, :length => {:maximum => 10}
	validates :serial_number, :presence => true, :uniqueness => true
	validates :purchase_date, :presence => true
	validates :vendor, :presence => true
	validate :check_future_date		
	
	attr_accessor :tags_field
	
	belongs_to :resource, :polymorphic => true	
	
	has_and_belongs_to_many :tags, :join_table => 'assets_tags'  
  has_many :asset_employee_mappings
	has_many :employees, :through => :asset_employee_mappings
	
	accepts_nested_attributes_for :resource
	
	def assigned_employee
		asset_employee_mappings.where(:status => "Assigned").first.employee 
	end
	
	def can_be_assigned?
		status != "Assigned" && status != "repair"
	end
  
  ## 2 conditions can be written together
  def check_future_date
		unless(purchase_date.blank?)  
			if(purchase_date > Time.now)
				errors.add(:base, 'Future Purchase date is not allowed')
			end
		end
  end

	def build_resource params
	 if(self.id.nil?)
	 	 r = self.resource_type.constantize.new params
	 	 self.resource = r
	 else
		 self.resource.update_attributes params
	 end	 
	end
   
  def change_tags_to_array
  	unless tags_field.blank?
			tags = self.tags_field.split(",")
			tags.each do |tag|
				if(tag_element = Tag.find_by_name(tag.strip))
					self.tags << tag_element
				else
					new_tag = Tag.create(:name => tag.strip)
					self.tags << new_tag				
				end	
			end
		end	
  end
  
end
