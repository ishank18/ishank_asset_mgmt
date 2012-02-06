class Asset < ActiveRecord::Base

  before_save :add_tags
  
	validates :name, :presence => true
	validates :status, :presence => true
	validates :cost, :presence => true
	validates :cost, :allow_blank => true, :numericality => true, :length => {:maximum => 10}
	validates :serial_number, :presence => true, :uniqueness => true
	validates :purchase_date, :presence => true
	validates :vendor, :presence => true
	validates :purchase_date, :date => { :before => Proc.new { Time.zone.now } }, :allow_blank => true
	
	attr_accessor :tags_field
	
	has_and_belongs_to_many :tags
  has_many :assignments
	has_many :employees, :through => :assignments

	scope :assignable, where(%{status not in ('#{STATUS["Assigned"]}', '#{STATUS["Repair"]}')})
	
	## Will return the search result according to the params provided
	def self.search asset, status, category, employee
		result = self.where("assets.name like ?", "%#{asset}%") if asset.present?
		result = (asset.blank? ? self : result).where("assets.type = ?", category) if category.present?
		result = ((asset.blank? && category.blank?) ? self : result).where("assets.status = ?", status) if status.present?
		result = result.joins(:assignments => :employee).where("employees.name like ? and asset_employee_mappings.date_returned is NULL", "%#{employee}%") if employee.present?
		result
	end	
	
	## Will return an active relation of employees to whome any asset is asssigned	
	def assigned_employee
		assignments.where(:date_returned => nil).first.try(:employee) 
	end
	
	## Will only let the assets to be assigned if status is not assigned and repair
	def can_be_assigned?
		![STATUS["Assigned"], STATUS["Repair"]].include?(status)
	end

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
