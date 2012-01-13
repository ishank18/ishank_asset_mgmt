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
	
	# Check ig join_table key is required
	has_and_belongs_to_many :tags
  has_many :asset_employee_mappings
	has_many :employees, :through => :asset_employee_mappings
	
	accepts_nested_attributes_for :resource

	## Will return an active relation of employees to whome any asset is asssigned	
	def assigned_employee
		asset_employee_mappings.where(:status => STATUS[4][1]).first.employee 
	end
	
	## Refer using constant - through out the app
	## Will only let the assets to be assigned if status is not assigned and repair
	def can_be_assigned?
		status != STATUS[4][1] && status != STATUS[3][1]
	end
  
  ## Checks that future purchase date is not alloted
  def check_future_date
		unless(purchase_date.blank?)  
      if(purchase_date > Time.now)
        errors.add(:base, 'Future Purchase date is not allowed')
      end
		end
  end

	## Used to add resource to the asset table using polymorphic association
	def build_resource params
	  # use new_record?
	 if(self.new_record?)
	 	 r = resource_type.constantize.new params
	 	 self.resource = r
	 else
		 self.resource.update_attributes params
	 end	 
	end
  
  ## Used to add tags, and make enteries in assets_tags table, will also check if the tag exists or not
  def change_tags_to_array
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
