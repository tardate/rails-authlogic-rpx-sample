class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
	def create
		@user = User.new(params[:user])
		@user.save do |result|
			if result
				flash[:notice] = "Successfully registered user."
				redirect_to articles_path
			else
				render :action => 'new'
			end
		end
	end
  
	def edit
		@user = current_user
		@user.valid?
	end
  
	def update
		@user = current_user
		@user.attributes = params[:user]
		@user.save do  |result|
			if result
				flash[:notice] = "Successfully updated user."
				redirect_to articles_path
			else
				render :action => 'edit'
			end
		end
	end
  
	def addrpxauth
		@user = current_user
		@user.save do  |result|
			if result
				flash[:notice] = "Successfully added RPX authentication for this account."
				redirect_to articles_path
			else
				render :action => 'edit'
			end
		end
	end
  
end
