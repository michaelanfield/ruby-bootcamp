require './lib/authenticate'

# Sets the Sinatra base directory to be sky-bill. This means it will look for templates in
# ./views rather than ./lib/views.
Sinatra::Base.set :root, __dir__

run Authenticate
