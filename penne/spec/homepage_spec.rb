require 'spec_helper'

describe HomePage do
  include Rack::Test::Methods

  let(:app) { subject }

  it 'should have a successful response' do
    get('/')

    expect(last_response).to be_ok
  end
end
