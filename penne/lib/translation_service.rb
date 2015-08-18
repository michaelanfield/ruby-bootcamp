require 'google_translate'
require 'google_translate/result_parser'

require 'nokogiri'
require 'pry'

# Provides a service to translate a given message to a given language.
class TranslationService
  FROM_LANG = 'en'

  attr_reader :translator

  def initialize(translator = GoogleTranslate.new)
    @translator = translator
  end

  def translate_page(page, language = nil)
    html = Nokogiri::HTML(page) do |config|
      config.noblanks
    end

    html.search('//text()').each do |text|
      text.content = translate text.content, language
    end

    html.to_s
  end

  private

  def language_valid?(language_code)
    _from_languages, to_languages = translator.supported_languages

    !to_languages.select! { |lang| lang.code == language_code }.empty?
  end

  def translate(message, language = nil)
    return message unless language

    fail UnsupportedLanguageError, "Sorry, #{language} is not supported." unless language_valid? language

    translation = translator.translate(FROM_LANG, language, message)
    ResultParser.new(translation).translation
  end

  # Describes an error encountered because a language supplied is not supported.
  class UnsupportedLanguageError < StandardError; end
end
