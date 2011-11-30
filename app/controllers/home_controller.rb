class HomeController < ApplicationController
		
		def index
			 p session["warden.user.admin.key"]
		end
		def search
		end
end
