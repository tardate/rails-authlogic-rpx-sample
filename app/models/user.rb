class User < ActiveRecord::Base
	acts_as_authentic do |c|
		#c.map_id = false
	end
	attr_accessible :username, :email, :password, :password_confirmation, :rpx_identifier

	validates_uniqueness_of   :username, :case_sensitive => false
	
end
