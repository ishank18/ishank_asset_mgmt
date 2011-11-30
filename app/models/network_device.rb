class NetworkDevice < ActiveRecord::Base
		has_one :asset, :as => :resource
end
