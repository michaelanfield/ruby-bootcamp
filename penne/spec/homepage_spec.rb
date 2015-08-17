require 'spec_helper'

describe HomePage do
  let(:app) { subject }
  let(:messages) do
    {
      default: 'Welcome to the next best thing!',
      german: 'Willkommen auf die nächste beste Sache !'
    }
  end

  before do
    allow(subject.translation_service).to receive(:language_valid?).and_return true
  end

  it 'should have a successful response with an english message' do
    get '/'

    expect(last_response).to be_ok
    expect(last_response.body).to include messages[:default]
  end

  it 'should call through to a translation service with a message' do
    expect(subject.translation_service).to receive(:translate).with(messages[:default], nil).and_return('anything')

    get '/'

    expect(last_response).to be_ok
  end

  it_behaves_like 'a URL language parser', '/home.de', 'de'
  it_behaves_like 'a URL language parser', '/hello/home.zh', 'zh'
  it_behaves_like 'a URL language parser', '/home.page.en', 'en'

  it 'should have a successful response with a message in german' do
    expect(subject.translation_service).to receive(:translate).with(messages[:default], 'de').and_return(messages[:german])

    get '/home.de'

    expect(last_response).to be_ok
    expect(last_response.body).to include messages[:german]
  end
end
