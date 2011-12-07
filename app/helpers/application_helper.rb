module ApplicationHelper
	include Devise::TestHelpers
	
	def date_to_string date_obj
  	if(date_obj != "" && date_obj != nil)
  		date_obj.strftime("%B %d, %Y")
  	else
  		""	
  	end	
  end

end
