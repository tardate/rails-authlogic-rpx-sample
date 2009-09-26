class UserSession < Authlogic::Session::Base
	#auto_register false
	rpx_key RPX_API_KEY
	rpx_extended_info
	
private

	# here you may override AuthlogicRpx::Session methods as required
	
	# map_rpx_data maps additional fields from the RPX response into the user object
	# override this in your session controller to change the field mapping
	# see https://rpxnow.com/docs#profile_data for the definition of available attributes
	#
#    def map_rpx_data
#		# map core profile data
#		self.attempted_record.email = @rpx_data['profile']['email'] if attempted_record.email.blank?
#		self.attempted_record.username = @rpx_data['profile']['preferredUsername'] if attempted_record.username.blank?
#
#		if rpx_extended_info?
#			# map some extended attributes
#		end
#	end
	
end