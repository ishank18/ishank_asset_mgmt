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
	validates :type, :presence => true
	
	attr_accessor :tags_field
	
	has_and_belongs_to_many :tags
  has_many :assignments
	has_many :employees, :through => :assignments

	scope :assignable, where(%{status not in ('#{STATUS["Assigned"]}', '#{STATUS["Repair"]}')})
	
	## Will return the search result according to the params provided
	def self.search params
	  if (params[:asset].present? || params[:asset_status].present? || params[:asset_type].present? || params[:start].present? || params[:end].present?)
  	  result = Asset.where("assets.#{params[:by]} like ?", "%#{params[:asset]}%")
  	  (result = result.where("assets.status = ?", params[:asset_status])) if params[:asset_status].present?
  	  (result = result.where("assets.type = ?", params[:asset_type])) if params[:asset_type].present?
  	  (result = result.where("assets.purchase_date >= ?", params[:start])) if params[:start].present?
  	  (result = result.where("assets.purchase_date <= ?", params[:end])) if params[:end].present?
      (result = result.joins(:assignments => :employee).where("employees.name like ? and asset_employee_mappings.date_returned is NULL", "%#{params[:employee]}%")) if params[:employee].present?
    elsif params[:employee].present?
      result = Employee.where("employees.name like ?", "%#{params[:employee]}%")
    else ## Returns a Arel object of Asset to avoid exception if no result is found
      result = Asset.where("1!=1")
    end
    p params[:employee]
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
