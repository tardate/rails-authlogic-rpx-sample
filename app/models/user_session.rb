class UserSession < Authlogic::Session::Base
	#auto_register false
	rpx_key RPX_API_KEY
	rpx_extended_info false
	
private

	# here you may override AuthlogicRpx::Session methods as required
	
	# map_rpx_data maps additional fields from the RPX response into the user object
	# override this in your session controller to change the field mapping
	# rename this method "map_rpx_data" to use for real
    def map_rpx_data_sample
		# map
		self.attempted_record.email = @rpx_data['profile']['email'] if attempted_record.email.blank?
		self.attempted_record.username = @rpx_data['profile']['preferredUsername'] if attempted_record.username.blank?

		if rpx_extended_info?
			# map some extended attributes
		end
	end
	
end