require 'sinatra'

# Handles an authentication request.
class Authenticate < Sinatra::Base
  get '/' do
    slim :login
  end
end
