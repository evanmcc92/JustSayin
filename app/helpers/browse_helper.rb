module BrowseHelper
    def signed_in?
    	!current_user.nil?
  	end
	def current_user=(user)
    	@current_user = user
  	end
end
