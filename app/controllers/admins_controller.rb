class AdminsController < ApplicationController
  
  def new
  	@admin = Admin.new
  end

	def create
		@admin = Admin.new(:email => params[:email])
		if @admin.save
			redirect_to :root, :alert => "Confirmation mail has been successfully send!"
		else
			render :action => "new"
		end	
	end
	
  def reset
		@admin = current_admin
	end
	
	def update_password
		@admin = current_admin
		if(@admin.update_attributes(params[:admin]))
			redirect_to root_path
		else
			render :action => "edit"
		end
	end
	
end
