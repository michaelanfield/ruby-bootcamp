require 'spec_helper'

describe Authenticate do
  include_context :rack_test

  it 'responds to get' do
    expect(self.respond_to? :get).to be true
  end

  it 'navigates to the login page' do
    get '/'

    expect(last_response.body).to include 'Sign in'
  end
end

# Test the template in isolation to ensure it has the necessary inputs and button
