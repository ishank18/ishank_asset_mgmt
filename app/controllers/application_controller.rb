class ApplicationController < ActionController::Base
	before_filter :authenticate_admin!
  protect_from_forgery
  	
  def string_to_date str
  	### Use try method

  	unless(str.blank?)
  		DateTime.strptime(str, "%m/%d/%Y")
  	else
  		nil	
  	end	
  end
  
  def date_to_string date_obj
  	### Use try method
  	
  	unless(date_obj.blank?)
  		date_obj.strftime("%m/%d/%Y")
  	else
  		""
  	end	
  end
  	
end
