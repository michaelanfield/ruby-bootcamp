require 'sinatra'
require 'sinatra/cookies'

require_relative 'helpers/skybill_services'

# Handles an authentication request.
class Authenticate < Sinatra::Base
  helpers Sinatra::Cookies, SkyBill::Services

  get '/' do
    slim :login
  end

  get '/bill' do
    redirect('/') unless cookies[:skybill_auth]

    customer_bill = bill_service.fetch_bill
    slim :bill, locals: {:bill => customer_bill}
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

  get '/logout' do
    cookies.clear
    redirect '/'
  end
end
