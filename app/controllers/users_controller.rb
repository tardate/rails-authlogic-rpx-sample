class UsersController < ApplicationController
	before_filter :require_no_user, :only => [:new, :create]
	before_filter :require_user, :except => [:new, :create]

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

	def show
		@user = current_user
	end
 
	def update
		@user = current_user
		@user.attributes = params[:user]
		if @user.save
			flash[:notice] = "Successfully updated user."
			redirect_back_or_default articles_path
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
			render :action => 'show'
		else
			render :action => 'edit'
		end
	end
  
end
