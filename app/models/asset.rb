class Asset < ActiveRecord::Base

  before_save :add_tags
  
	validates :name, :presence => true
	validates :status, :presence => true
#	validates :resource_type, :presence => true
	validates :cost, :presence => true
	validates :cost, :allow_blank => true, :numericality => true, :length => {:maximum => 10}
	validates :serial_number, :presence => true, :uniqueness => true
	validates :purchase_date, :presence => true
	validates :vendor, :presence => true
	validates :purchase_date, :date => { :before => Proc.new { Time.zone.now } }, :allow_blank => true
	
	attr_accessor :tags_field, :type

	
	has_and_belongs_to_many :tags
  has_many :assignments
	has_many :employees, :through => :assignments
#		accepts_nested_attributes_for :resource

	scope :can_be_assigned_from_category, lambda { |category|
		where(%{type = ? and status not in ('#{STATUS["Assigned"]}', '#{STATUS["Repair"]}')}, category)
	}

	## Will return an active relation of employees to whome any asset is asssigned	
	def assigned_employee
		assignments.where(:is_active => true).first.employee 
	end
	
	## Will only let the assets to be assigned if status is not assigned and repair
	
  # Can be written like this
  # ![STATUS["Assigned"], STATUS["Repair"]].include?(status) 
	def can_be_assigned?
		(!status.include? STATUS["Assigned"]) && (!status.include? STATUS["Repair"])
	end

#	## Used to add resource to the asset table using polymorphic association
#	def build_resource params
#	 if(new_record?)
#	 	 r = resource_type.constantize.new params
#	 	 self.resource = r
#	 else
#		 resource.update_attributes params
#	 end	 
#	end
  
  ## Used to add tags, and make enteries in assets_tags table, will also check if the tag exists or not
  def add_tags
  	unless tags_field.blank?
			tags = tags_field.split(",")
			tags.each do |tag|
        self.tags << Tag.find_or_initialize_by_name(tag.strip)
			end
		end	
  end
  
end
