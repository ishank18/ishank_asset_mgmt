class Assignment < ActiveRecord::Base

	set_table_name "asset_employee_mappings"

	before_create :check_asset_status
	after_create :update_status
	after_update :update_aem_asset

	validates :asset_id, :presence => true
	validates :employee_id, :presence => true
	validates :date_returned, :on => :update, :presence => true
	validates :date_issued, :presence => true, :date => { :before => Proc.new { Time.zone.now } }, :allow_blank => true
	validates :date_returned, :on => :update, :date => { :before => Proc.new { Time.zone.now } }, :allow_blank => true
	validates :date_returned, :date => { :after => :date_issued }, :allow_blank => true
	
	validate :temporarly_assignment_date, :on => :create
	
  # What does this do?
	attr_accessor :assignment_type
	
	
	has_one :comment, :as => :resource
	belongs_to :asset
	belongs_to :employee
	
	accepts_nested_attributes_for :comment, :allow_destroy => true, :reject_if => proc { |attribute| attribute[:body].blank?  }
	
	## Scope which will return assets which are assigned after checking Asset & AEM status
	scope :assigned_assets, joins(:asset).
		                      where("assets.status = ? AND asset_employee_mappings.date_returned is NULL", STATUS["Assigned"])	
	
	## Used to update status of AEM and assets when a new asset is assigned
	def update_status
		asset.update_attributes(:status => STATUS["Assigned"])
	end
	
	def check_asset_status
		asset.can_be_assigned?
	end
	
	def update_aem_asset
		asset.update_attributes(:status => STATUS["Spare"])
	end

	## Checks if the date_returned is not blank if assignment type is temporary
	def temporarly_assignment_date
		errors.add(:expected_return_date, " can't be blank on Temporarly Assignment") if assignment_type == "false" && expected_return_date.blank?
	end
	
end

