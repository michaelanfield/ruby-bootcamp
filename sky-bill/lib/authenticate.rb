require 'sinatra'
require 'sinatra/cookies'

# Handles an authentication request.
class Authenticate < Sinatra::Base
  helpers Sinatra::Cookies

  get '/' do
    slim :login
  end

  get '/bill' do
    redirect('/') unless cookies[:skybill_auth]
    slim :bill
  end

  post '/login' do
    username = params[:username]
    password = params[:password]

    if username == 'me@you.com' && password == 'p455w0rd'
      cookies[:skybill_auth] = true
      redirect '/bill'
    else
      redirect '/'
    end
  end

  post '/logout' do
    cookies.clear
    redirect '/'
  end
end
