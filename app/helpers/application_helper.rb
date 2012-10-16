module ApplicationHelper
	include Devise::TestHelpers
	
	def date_to_string date_obj
    date_obj.blank? ? "" : date_obj.strftime("%B %d, %Y")
  end

	def flash_message
		message = ""
		close = content_tag :button, "x", :class => "close", "data-dismiss" => "alert", :type => "button"
		[:notice, :alert, :success].each do |type|
			if(!flash[type].blank?)
				message += content_tag :div, "#{flash[type]} #{close}".html_safe, :class => "alert #{(type == :notice) ? 'alert-info' : '' }"
			end	
		end
		message.html_safe
	end
	
	def class_name controller, action
		"active" if params[:controller] == controller && params[:action] == action
	end
	
	def get_all_employees
		Employee.all.collect { |emp| [emp.name, emp.id] }
	end	

	def mark_required(object, attribute)
		"*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
	end
	
end
