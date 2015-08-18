shared_examples 'a URL language and page reference parser' do |url, language_code, page_reference|
  it "extracts #{language_code} and #{page_reference} from #{url}" do
    page_ref, lang_code = subject.send :extract_path_and_language_from, url

    expect(page_ref).to eq page_reference
    expect(lang_code).to eq language_code
  end
end
