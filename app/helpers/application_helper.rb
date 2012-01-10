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
	
	def menu_link_to name, uri_path
		link_to name, uri_path, :class => ("highlighted" if request.fullpath == uri_path)
	end
	
	def get_all_employees
		options_for_emp = []
		Employee.all.each do |emp|
  		currOpt = []
  		currOpt << emp.name
  		currOpt << emp.id
  		options_for_emp << currOpt
  	end
  	options_for_emp
	end	
	
end
