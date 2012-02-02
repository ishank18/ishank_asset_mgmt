class AdminsController < ApplicationController
  
  def new
  	@admin = Admin.new
  end

	## Used to create new Admin and will send the confirmation mail to them
	def create
		@admin = Admin.new(:email => params[:email])
		if @admin.save
			redirect_to :root, :alert => "Confirmation mail has been successfully send!"
		else
			render :action => "new"
		end	
	end
	
	## Form to edit password for the admins
  def reset
		@admin = current_admin
	end
	
	## Will update password of admin after filling the reset form
	def update_password
		@admin = current_admin
		if(@admin.update_attributes(params[:admin]))
			redirect_to root_path
		else
			render :action => "reset"
		end
	end
	
end
