# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails_authlogic_rpx_sample_session',
  :secret      => '7c1b646c73c6cbe9fb7f21f7b4c66ddb832265d3b54afeda45e5356464e266f1d45c5dc059feacadec5fd4a575e35544f44cba53b5e9a5e055d8825315790521'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
