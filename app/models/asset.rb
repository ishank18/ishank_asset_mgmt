class Asset < ActiveRecord::Base
  ### validates presens of purchase date
  
	belongs_to :resource, :polymorphic => true
	validates_presence_of :name, :status
	validates_numericality_of :cost, :allow_nil => true
	validates_length_of :cost, :maximum => 10
	has_and_belongs_to_many :tags, :join_table => 'assets_tags'
	has_many :asset_employee_mappings
end
