module AssetEmployeeMappingsHelper
	def show_scheduled_date date_obj
		unless(date_obj.nil?)
			" Original Return Date : <b>#{date_to_string date_obj}</b>".html_safe
		end
	end
end
