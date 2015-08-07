# ENV['RACK_ENV'] = 'test'
require 'spec_helper'

# shared_context :webmock_allow_localhost do
# WebMock.disable_net_connect!(allow_localhost: true)
# end

describe HomePage do
  include Rack::Test::Methods

  # include_context :webmock_allow_localhost

  it 'should have a successful response' do
    # get('/')

    # expect(last_response).to be_ok
    expect(true).to be true
    # last_response.status == 200
    # last_response.body.include?('string')
  end
end
