class User < ActiveRecord::Base
	acts_as_authentic do |c|
		c.account_mapping_mode :auto
		c.account_merge_enabled true
	end
	
	attr_accessible :username, :email, :password, :password_confirmation, :rpx_identifier

	validates_uniqueness_of   :username, :case_sensitive => false

	has_many :articles
	has_many :comments
	
private

	# map_added_rpx_data maps additional fields from the RPX response into the user object during the "add RPX to existing account" process.
	# Override this in your user model to perform field mapping as may be desired
	# See https://rpxnow.com/docs#profile_data for the definition of available attributes
	#
	# "self" at this point is the user model. Map details as appropriate from the rpx_data structure provided.
	#
	def map_added_rpx_data( rpx_data )
		# map some additional fields, e.g. photo_url
		self.photo_url = rpx_data['profile']['photo'] if photo_url.blank?
	end

	# before_merge_rpx_data provides a hook for application developers to perform data migration prior to the merging of user accounts.
	# This method is called just before authlogic_rpx merges the user registration for 'from_user' into 'to_user'
	# Authlogic_RPX is responsible for merging registration data.
	#
	# By default, it does not merge any other details (e.g. application data ownership)
	#
	def before_merge_rpx_data( from_user, to_user )
		RAILS_DEFAULT_LOGGER.info "in before_merge_rpx_data: migrate articles and comments from #{from_user.username} to #{to_user.username}"
		to_user.articles << from_user.articles
		to_user.comments << from_user.comments
	end
	
	# after_merge_rpx_data provides a hook for application developers to perform account clean-up after authlogic_rpx has
	# migrated registration details.
	#
	# By default, does nothing. It could, for example, be used to delete or disable the 'from_user' account
	#
	def after_merge_rpx_data( from_user, to_user )
		RAILS_DEFAULT_LOGGER.info "in after_merge_rpx_data: destroy #{from_user.inspect}"	
		from_user.destroy
	end

end
