# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_homeworkbin_session',
  :secret      => '5528e9bf22528302ef6c9b04c7825e33d2c13ed61ae98a9be49d8b4a3891d0bac9e76f6186f87ab22de6dc3c50ce067ec5afb0c2e64b6a34b1bbbff004c1cbaa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
