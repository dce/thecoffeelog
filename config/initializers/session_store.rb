# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_feedmail_session',
  :secret      => 'c37f16291cf94e9fc023ae76c8ef227f51c88448dd74b5186d72daa5a3bf45128085c1371bbf9a806f180489afb742dd1c007b3ecfda940a7c343bada04e71fb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
