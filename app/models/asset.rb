class Asset < ActiveRecord::Base
	belongs_to :resource, :polymorphic => true
	validates_presence_of :name
	validates_numericality_of :cost, :allow_nil => true
	validates_length_of :cost, :maximum => 10
end
