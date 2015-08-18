require 'google_translate'
require 'google_translate/result_parser'
require 'nokogiri'

# Provides a service to translate a given message to a given language.
class TranslationService
  FROM_LANG = 'en'

  attr_reader :page_cache, :translator

  def initialize(translator = GoogleTranslate.new)
    @page_cache = {}
    @translator = translator
  end

  def translate_page(page, language = nil, cache_name = :default)
    return page unless language

    key = build_page_cache_key cache_name, language

    page_cache[key] = translate_page_text page, language unless page_cache[key]
  end

  private

  def build_page_cache_key(cache_name, language_code)
    "#{cache_name}::#{language_code}"
  end

  def language_valid?(language_code)
    _from_languages, to_languages = translator.supported_languages

    !to_languages.select! { |lang| lang.code == language_code }.empty?
  end

  def translate(message, language = nil)
    fail UnsupportedLanguageError, "Sorry, #{language} is not supported." unless language_valid? language

    translated_message = translator.translate(FROM_LANG, language, message)
    ResultParser.new(translated_message).translation
  end

  def translate_page_text(page, language)
    html = Nokogiri::HTML(page) do |config|
      config.noblanks
    end

    html.search('//text()').each do |text|
      text.content = translate text.content, language
    end

    html.to_s
  end

  # Describes an error encountered because a language supplied is not supported.
  class UnsupportedLanguageError < StandardError; end
end
