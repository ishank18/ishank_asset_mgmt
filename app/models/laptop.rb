class Laptop < Asset
	validates :operating_system, :presence => true
end
