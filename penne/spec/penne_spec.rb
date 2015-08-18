require 'spec_helper'

describe Penne do
  let(:app) { subject }
  let(:messages) do
    {
      default: 'Welcome to the next best thing!',
      german: 'Willkommen auf die nächste beste Sache !'
    }
  end

  before do
    default_msg = messages[:default]
    german_msg = messages[:german]

    described_class.page('/home') { default_msg }
    described_class.page('/home.de') { german_msg }

    allow(subject.translation_service).to receive(:language_valid?).and_return true
  end

  it 'should have a successful response with an english message' do
    get '/home'

    expect(last_response).to be_ok
    expect(last_response.body).to include messages[:default]
  end

  it 'should call through to a translation service with a message' do
    expect(subject.translation_service).to receive(:translate).with(messages[:default], nil).and_return('anything')

    get '/home'

    expect(last_response).to be_ok
  end

  it_behaves_like 'a URL language and page reference parser', '/home.de', 'de', '/home'
  it_behaves_like 'a URL language and page reference parser', '/hello/home.zh', 'zh', '/hello/home'
  it_behaves_like 'a URL language and page reference parser', '/home.page.en', 'en', '/home.page'

  it 'should have a successful response with a message in german' do
    expect(subject.translation_service).to receive(:translate).with(messages[:default], 'de').and_return(messages[:german])

    get '/home.de'

    expect(last_response).to be_ok
    expect(last_response.body).to include messages[:german]
  end

  it 'will return a 404 if the page is not found' do
    get '/404'

    expect(last_response.status).to eq 404
    expect(last_response.body).to eq 'Page not found'
  end
end
