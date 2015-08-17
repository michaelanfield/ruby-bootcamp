require 'spec_helper'

describe HomePage do
  let(:app) { subject }

  it 'will return a string when body is called' do
    expect(HomePage.new.body).to eq 'Welcome to the homepage for the next best thing!'
  end
end
