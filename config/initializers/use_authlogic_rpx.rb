$LOAD_PATH << '~/MyGithub/authlogic_rpx/lib'
require 'authlogic_rpx'

RPX_API_KEY = ENV['RARS_RPX_API_KEY']
RPX_APP_NAME = ENV['RARS_RPX_APP_NAME']
raise "RPX/Janrain Engage API key must be defined: ENV['RARS_RPX_API_KEY']" unless defined? RPX_API_KEY
raise "RPX/Janrain Engage Application Name must be defined: ENV['RARS_RPX_APP_NAME']" unless defined? RPX_APP_NAME
