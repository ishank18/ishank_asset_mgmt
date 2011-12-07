class HomeController < ApplicationController
		
		def index
			@tags = Tag.all
		end
		
		  
		def search
			@query_for_asset = params[:query_for_asset]
			@query_for_emp = params[:query_for_emp]
			
			asset_result = Asset.where("name like '%#{@query_for_asset}%'")
			emp_result = Employee.where("name like '%#{@query_for_emp}%'")
			### Put in model
			if(@query_for_emp == "")
				@result = asset_result
			elsif(@query_for_asset == "")
				@result = emp_result
			else
				a = ""
				e = ""
				asset_result.collect { |ar| a = a + ar.id.to_s + "," }
				emp_result.collect { |er| e = e + er.id.to_s + "," } 
				a = a[0..a.length-2]
				e = e[0..e.length-2]
				@result = AssetEmployeeMapping.where("asset_id in (#{a}) and employee_id in (#{e})")
			end
			
		end
		
end
