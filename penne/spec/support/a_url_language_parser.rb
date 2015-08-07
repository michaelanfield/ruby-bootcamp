shared_examples 'a URL language parser' do |url, language_code|
  it "extracts #{language_code} from #{url}" do
    get url

    expect(subject.translate_to).to eq language_code
  end
end
