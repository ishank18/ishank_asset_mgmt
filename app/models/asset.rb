class Asset < ActiveRecord::Base

  ### validates presens of purchase date  -  Done
  before_save :add_tags
  
	validates :name, :presence => true
	validates :status, :presence => true
	validates :resource_type, :presence => true
	validates :cost, :presence => true
	validates :cost, :allow_blank => true, :numericality => true, :length => {:maximum => 10}
	validates :serial_number, :presence => true, :uniqueness => true
	validates :purchase_date, :presence => true
	validates :vendor, :presence => true
	
	validate :check_future_date		
	
	attr_accessor :tags_field
	
	belongs_to :resource, :polymorphic => true	
	
	# Check ig join_table key is required - Done
	has_and_belongs_to_many :tags
  has_many :asset_employee_mappings
	has_many :employees, :through => :asset_employee_mappings
	
	accepts_nested_attributes_for :resource

	## Will return an active relation of employees to whome any asset is asssigned	
	def assigned_employee
		asset_employee_mappings.where(:status => STATUS["Assigned"]).first.employee 
	end
	
	## Refer using constant - through out the app - Done
	## Will only let the assets to be assigned if status is not assigned and repair
	def can_be_assigned?
		(!status.include? STATUS["Assigned"]) && (!status.include? STATUS["Repair"])
	end
  
  ## Checks that future purchase date is not alloted
  def check_future_date
		if (!purchase_date.blank?) && (purchase_date > Time.now)
      errors.add(:purchase_date, 'cant be a future date')
		end
  end

	## Used to add resource to the asset table using polymorphic association
	def build_resource params
	  # use new_record? - Done
	 if(new_record?)
	 	 r = resource_type.constantize.new params
	 	 self.resource = r
	 else
		 resource.update_attributes params
	 end	 
	end
  
  ## Used to add tags, and make enteries in assets_tags table, will also check if the tag exists or not
  def add_tags
  	unless tags_field.blank?
			tags = tags_field.split(",")
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
