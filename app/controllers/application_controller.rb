class ApplicationController < ActionController::Base
	before_filter :authenticate_admin!
  protect_from_forgery
  def string_to_date str
  	### Use try method
		!str.blank? ? DateTime.strptime(str, "%m/%d/%Y"):nil
  end
  
  def date_to_string date_obj
  	### Use try method
		!date_obj.blank? ? date_obj.strftime("%m/%d/%Y"):nil
  end
  	

  	
end
