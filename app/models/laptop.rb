class Laptop < ActiveRecord::Base
	has_one :asset, :as => :resource
end
