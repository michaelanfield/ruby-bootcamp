require 'spec_helper'

describe TranslationService do
  let(:message) { 'my awesome message' }

  it 'should be initialized with a google translator by default' do
    expect(subject.translator).to be_a GoogleTranslate
  end

  it 'should return the message if no language to is provided' do
    expect(subject.translator).not_to receive(:translate)

    expect(subject.translate message).to eq message
  end

  it 'should use en as the default language from' do
    expected_translated_message = "Translated: #{message}"

    expect(subject.translator).to receive(:translate).with('en', 'de', anything).and_return([[[expected_translated_message]]])
    expect(subject).to receive(:language_valid?).with('de').and_return true

    translated_message = subject.translate 'my string', 'de'
    expect(translated_message).to eq expected_translated_message
  end

  it 'should only allow supported languages' do
    expect { subject.translate message, 'XX' }.to raise_error TranslationService::UnsupportedLanguageError
  end
end
