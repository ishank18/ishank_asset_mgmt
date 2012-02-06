class Comment < ActiveRecord::Base
	belongs_to :resource, :polymorphic => true
end
