class ApplicationController < ActionController::Base
	before_filter :authenticate_admin!
  protect_from_forgery
  	
  def string_to_date str
  	unless(str.blank?)
  		DateTime.strptime(str, "%m/%d/%Y")
  	else
  		nil	
  	end	
  end
  
  def date_to_string date_obj
  	unless(date_obj.blank?)
  		date_obj.strftime("%m/%d/%Y")
  	else
  		""
  	end	
  end
  	
end
