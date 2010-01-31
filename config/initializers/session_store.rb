# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_blogmi_session',
  :secret => '4d6f084f840e9281cde6e363806cd59ef75a819b9e7049512db46776f87d863979f35e822bf3b0c8cadd9aca8aeab7e76279be0a933d8caf3bbb6de47a34fb00'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
