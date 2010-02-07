# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_blogmi_session',
  :secret => 'f7c59eb0351cb1c46ca50f91b4edfe24bbfed122d676667c093b335b3ba972441cd73907913ce0f8b3707a64d81164b9d54746bec3645df7fe2abce6bf27360e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
