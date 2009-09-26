class UsersController < ApplicationController
	def new
		@user = User.new
	end
  
	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:notice] = "Successfully registered user."
			redirect_to articles_path
		else
			render :action => 'new'
		end
	end
  
	def edit
		@user = current_user
		@user.valid?
	end
  
	def update
		@user = current_user
		@user.attributes = params[:user]
		if @user.save
			flash[:notice] = "Successfully updated user."
			redirect_to articles_path
		else
			render :action => 'edit'
		end
	end

	# This action has the special purpose of receiving an update of the RPX identity information
	# for current user - to add RPX authentication to an existing non-RPX account.
	# RPX only supports :post, so this cannot simply go to update method (:put)
	def addrpxauth
		@user = current_user
		if @user.save
			flash[:notice] = "Successfully added RPX authentication for this account."
			redirect_to articles_path
		else
			render :action => 'edit'
		end
	end
  
end
