class UserSessionsController < ApplicationController
	before_filter :require_no_user, :only => [:new, :create]
	before_filter :require_user, :except => [:new, :create]
	
	def new
		@user_session = UserSession.new
	end
  
	# Main method to create a user session and perform the authentication (password or RPX)
	#
	# this is fairly naively laid out, but basically showing some of the actions you might take
	# after creating a session (which may have involed user auto_registration via RPX) e.g.
	#  - if a new registration, force them to go via a registration follow-up page
	#  - if registration details not complete, bounce the user over the profile editing page
	#
	def create
		@user_session = UserSession.new(params[:user_session])
		if @user_session.save
			if @user_session.new_registration?
				flash[:notice] = "Welcome! As a new user, please review your registration details before continuing.."
				redirect_to edit_user_path( :current )
			else
				if @user_session.registration_complete?
					flash[:notice] = "Successfully signed in."
					redirect_back_or_default articles_path
				else
					flash[:notice] = "Welcome back! Please complete required registration details before continuing.."
					redirect_to edit_user_path( :current )
				end
			end
		else
			flash[:error] = "Failed to login or register."
			redirect_to new_user_session_path
		end
	end
  
	def destroy
		@user_session = current_user_session
		@user_session.destroy if @user_session
		flash[:notice] = "Successfully signed out."
		redirect_to articles_path
	end
	
end
