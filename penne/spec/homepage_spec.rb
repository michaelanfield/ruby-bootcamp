require 'spec_helper'

describe HomePage do
  let(:app) { subject }
  let(:messages) do
    {
      default: 'Welcome to the next best thing!',
      german: 'Willkommen auf die nächste beste Sache !'
    }
  end

  it 'should have a successful response with an english message' do
    get '/'

    expect(last_response).to be_ok
    expect(last_response.body).to include messages[:default]
  end

  it 'should call through to a translation service with a message' do
    allow(subject.translation_service).to receive(:translate).with(messages[:default]).and_return('anything')

    get '/'

    expect(last_response).to be_ok
  end

  skip 'should have a successful response with a message in german' do
    get '/home.de'

    expect(last_response).to be_ok
    expect(last_response.body).to include messages[:german]
  end
end
