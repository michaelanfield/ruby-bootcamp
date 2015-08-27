require 'simplecov'

SimpleCov.command_name 'test:features'

require './lib/authenticate'

# Fixes an issue with I18n :en is not a valid locale
I18n.enforce_available_locales = false

# Sets the Sinatra base directory to be sky-bill. This means it will look for templates in
# ./views rather than ./lib/views
Sinatra::Base.set :root, __dir__

run Authenticate
