class UserSession < Authlogic::Session::Base
	#auto_register false
	rpx_key RPX_API_KEY
	
private

	# here you may override AuthlogicRpx::Session methods as required, e.g.
	# def map_rpx_data
	# end
	
end