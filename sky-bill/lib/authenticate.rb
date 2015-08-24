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

  get '/login' do
    redirect '/'
  end

  post '/login' do
    username = params[:username]
    password = params[:password]

    if 'me@you.com' == username && 'p455w0rd' == password
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
