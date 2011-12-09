module ApplicationHelper
	include Devise::TestHelpers
	
	def date_to_string date_obj
  	if(date_obj != "" && date_obj != nil)
  		date_obj.strftime("%B %d, %Y")
  	else
  		""	
  	end	
  end

	def flash_message
		
		message = ""
		[:notice, :alert].each do |type|
			if(!flash[type].blank?)
				message += content_tag :div, flash[type], :class => "#{type}"
			end	
		end
		message.html_safe
	end
end
