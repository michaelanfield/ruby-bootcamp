require 'sinatra'

# Handles an authentication request.
class Authenticate < Sinatra::Base
  get '/' do
    slim :login
  end

  post '/login' do
    username = params[:username]
    password = params[:password]
    if username == 'me@you.com' && password == 'p455w0rd'
      slim :bill
    else
      redirect '/'
    end
  end
end
