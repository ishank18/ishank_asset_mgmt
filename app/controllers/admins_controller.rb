class AdminsController < ApplicationController
  
  def new
  	@admin = Admin.new
  end

	def create
		@admin = Admin.new(:email => params[:email])
		if(@admin.save)
			redirect_to :root, :alert => "Confirmation mail has been successfully send!"
		else
			render :partial => "form"
		end	
	end
	
end
