class MobilePhone < ActiveRecord::Base
		has_one :asset, :as => :resource
		validates :operating_system, :presence => true
end
