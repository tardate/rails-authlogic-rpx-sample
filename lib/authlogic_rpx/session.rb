module AuthlogicRpx
	# This module is responsible for adding all of the RPX goodness to the Authlogic::Session::Base class.
	module Session
		# Add a simple rpx_identifier attribute and some validations for the field.
		def self.included(klass)
			klass.class_eval do
				extend Config
				include Methods
			end
		end
		
		module Config
		  
			def find_by_rpx_identifier_method(value = nil)
				rw_config(:find_by_rpx_identifier_method, value, :find_by_rpx_identifier)
			end
			alias_method :find_by_rpx_identifier_method=, :find_by_rpx_identifier_method

			# Auto Register is enabled by default. 
			# Add this in your Session object if you need to disable auto-registration via rpx
			#
			def auto_register(value=true)
				auto_register_value(value)
			end
			def auto_register_value(value=nil)
				rw_config(:auto_register,value,true)
			end      
			alias_method :auto_register=,:auto_register

			# Add this in your Session object to set the RPX API key 
			# RPX won't work without the API key. Set it here if not already set in your app configuration.
			#
			def rpx_key(value=nil)
				rpx_key_value(value)
			end
			def rpx_key_value(value=nil)
				if ! inheritable_attributes.include?(:rpx_key) 
					RPXNow.api_key = value 
				end
				rw_config(:rpx_key,value,false)
			end
			alias_method :rpx_key=,:rpx_key
		end
		
		module Methods
		  
			def self.included(klass)
				klass.class_eval do
					attr_accessor :new_registration
					attr_accessor :added_rpx_identifier
					attr_accessor :rpx_data
					after_persisting :add_rpx_identifier, :if => :adding_rpx_identifier?
					validate :validate_by_rpx, :if => :authenticating_with_rpx?
				end
			end
		  


			# Determines if the authenticated user is also a new registration.
			# For use in the session controller to help direct the most appropriate action to follow.
			# 
			def new_registration?
				new_registration
			end
			
			# Determines if the authenticated user has a complete registration (no validation errors)
			# For use in the session controller to help direct the most appropriate action to follow.
			# 
			def registration_complete?
				attempted_record && attempted_record.valid?
			end

		private
			def authenticating_with_rpx?
				controller.params[:token] && !controller.params[:add_rpx]
			end

			def find_by_rpx_identifier_method
				self.class.find_by_rpx_identifier_method
			end

			# Tests if auto_registration is enabled (on by default)
			#
			def auto_register?
				self.class.auto_register_value
			end
			
			def adding_rpx_identifier?
				controller.params[:token] && controller.params[:add_rpx]
			end
			
			# the main RPX magic. At this pont, a session is being validated and we know RPX identifier
			# has been provided. We'll callback to RPX to verify the token, and authenticate the matching 
			# user. 
			# If no user is found, and we have auto_register enabled (default) this method will also 
			# create the user registration stub.
			#
			# On return to the controller, you can test for new_registration? and registration_complete?
			# to determine the most appropriate action
			#
			def add_rpx_identifier
				RPXNow.user_data(controller.params[:token]) {|raw|
					self.added_rpx_identifier = raw['profile']['identifier']
					#self.record.rpx_identifier  = added_rpx_identifier - violates AR validation
				}
			end
			
			# the main RPX magic. At this pont, a session is being validated and we know RPX identifier
			# has been provided. We'll callback to RPX to verify the token, and authenticate the matching 
			# user. 
			# If no user is found, and we have auto_register enabled (default) this method will also 
			# create the user registration stub.
			#
			# On return to the controller, you can test for new_registration? and registration_complete?
			# to determine the most appropriate action
			#
			def validate_by_rpx
				@rpx_data = RPXNow.user_data(controller.params[:token]) {|raw|
					user_data = {}
					user_data[:rpx_identifier] = raw['profile']['identifier']
					user_data[:provider_name] = raw['profile']['providerName']

					user_data[:email] = raw['profile']['email']
					user_data[:name] = raw['profile']['displayName']
					user_data[:username] = raw['profile']['preferredUsername']

					user_data[:id] = raw['profile']['primaryKey'].to_i if raw['profile']['primaryKey']
					user_data
				}

				# If we don't have a valid sign-in, give-up at this point
				if @rpx_data.nil?
					errors.add_to_base("Authentication failed. Please try again.")
					return false
				end
				
				self.attempted_record = klass.send(find_by_rpx_identifier_method, @rpx_data[:rpx_identifier])
				
				# so what do we do if we can't find an existing user matching the RPX authentication..
				if !attempted_record
					if auto_register?   
						self.attempted_record = klass.new( :rpx_identifier=>@rpx_data[:rpx_identifier] )     
						map_rpx_data
						# save the new user record - without session maintenance else we get caught in a self-referential hell,
						# since both session and user objects invoke each other upon save
						self.new_registration=true
						attempted_record.save_without_session_maintenance
					else
						errors.add_to_base("We did not find any accounts with that login. Enter your details and create an account.")
						return false
					end
				end
				
			end

			# this method maps additional fields from the RPX response into the user object
			# override this in your session controller to change the field mapping
			def map_rpx_data
				self.attempted_record.email = rpx_data[:email] if attempted_record.email.blank?
				self.attempted_record.username = rpx_data[:username] if attempted_record.username.blank?
			end
	
		end
		
	end
end