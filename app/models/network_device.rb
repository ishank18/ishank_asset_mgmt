class NetworkDevice < ActiveRecord::Base
		has_one :asset, :as => :resource
		validates :location, :presence => true
end
