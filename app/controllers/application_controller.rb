class ApplicationController < ActionController::Base
	before_filter :authenticate_admin!
  protect_from_forgery
  	
  def string_to_date str
  	if(str != "" && str != nil)
  		DateTime.strptime(str, "%m/%d/%Y")
  	else
  		nil	
  	end	
  end
  
  def date_to_string date_obj
  	if(date_obj != "" && date_obj != nil)
  		date_obj.strftime("%m/%d/%Y")
  	else
  		""
  	end	
  end
  	
end
