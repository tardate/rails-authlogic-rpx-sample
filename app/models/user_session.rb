class UserSession < Authlogic::Session::Base
	#auto_register false
	rpx_key RPX_API_KEY
	rpx_extended_info
	
private

	# here you may override AuthlogicRpx::Session methods as required
	
	# map_rpx_data maps additional fields from the RPX response into the user object during auto-registration.
	# Override this in your session model to change the field mapping
	# See https://rpxnow.com/docs#profile_data for the definition of available attributes
	#
	# In this procedure, you will be writing to fields of the "self.attempted_record" object, pulling data from the @rpx_data object.
	#
	# WARNING: if you are using auto-registration, any fields you map should NOT have constraints enforced at the database level.
	# authlogic_rpx will optimistically attempt to save the user record during registration, and 
	# violating a database constraint will cause the authentication/registration to fail.
	#
	# You can/should enforce any required validations at the model level e.g.
	#   validates_uniqueness_of   :username, :case_sensitive => false
	# This will allow the auto-registration to proceed, and the user can be given a chance to rectify the validation errors
	# on your user profile page.
	#
	# If it is not acceptable in your application to have user records created with potential validation errors in auto-populated fields, you
	# will need to override map_rpx_data and implement whatever special handling makes sense in your case. For example:
	#   - directly check for uniqueness and other validation requirements
	#   - automatically "uniquify" fields like username
	#   - save conflicting profile information to "pending user review" columns or a seperate table
	#
    def map_rpx_data
		# map core profile data using authlogic indirect column names
		self.attempted_record.send("#{klass.login_field}=", @rpx_data['profile']['preferredUsername'] ) if attempted_record.send(klass.login_field).blank?
		self.attempted_record.send("#{klass.email_field}=", @rpx_data['profile']['email'] ) if attempted_record.send(klass.email_field).blank?

		# map some other columns explicitly e.g. photo_url
		self.attempted_record.photo_url = @rpx_data['profile']['photo'] if attempted_record.photo_url.blank?

		if rpx_extended_info?
			# map some extended attributes
		end
	end

	# similar to map_rpx_data, except this is invoked at every user login
	# it allows you to keep relatively volatile information in your user profile updated from RPX
	#
	def map_rpx_data_each_login
		# we'll always update photo_url
		self.attempted_record.photo_url = @rpx_data['profile']['photo']
	end
	
end