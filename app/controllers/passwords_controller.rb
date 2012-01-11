class PasswordsController < ApplicationController 
	def edit
		@admin = current_admin
	end
	def update
		@admin = current_admin
		if(@admin.update_attributes(params[:admin]))
			redirect_to root_path
		else
			render :action => "edit"
		end
	end
end
