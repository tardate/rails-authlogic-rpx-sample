class User < ActiveRecord::Base
	acts_as_authentic do |c|
		#c.map_id = false
	end
	attr_accessible :username, :email, :password, :password_confirmation, :rpx_identifier

	validates_uniqueness_of   :username, :case_sensitive => false

private

	# map_added_rpx_data maps additional fields from the RPX response into the user object during the "add RPX to existing account" process.
	# Override this in your user model to perform field mapping as may be desired
	# See https://rpxnow.com/docs#profile_data for the definition of available attributes
	#
	# By default, it only maps the rpx_identifier field.
	#
	def map_added_rpx_data( rpx_data )
		self.rpx_identifier = rpx_data['profile']['identifier']

		# map some additional fields, e.g. photo_url
		self.photo_url = @rpx_data['profile']['photo'] if photo_url.blank?
	end
			
end
