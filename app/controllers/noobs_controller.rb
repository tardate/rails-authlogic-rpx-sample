class NoobsController < ApplicationController
	before_filter :require_no_user, :only => [:new, :create]
	before_filter :require_user, :except => [:new, :create]

	def new
		@noob = Noob.new
	end
  
	def create
		@noob = Noob.new(params[:noob])
		if @noob.save
			flash[:notice] = "Successfully registered user."
			redirect_to articles_path
		else
			render :action => 'new'
		end
	end
  
	def edit
		@noob = current_user
		@noob.valid?
	end

	def show
		@noob = current_user
	end
 
	def update
		@noob = current_user
		@noob.attributes = params[:noob]
		if @noob.save
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
		@noob = current_user
		if @noob.save
			flash[:notice] = "Successfully added RPX authentication for this account."
			render :action => 'show'
		else
			render :action => 'edit'
		end
	end
  
end
