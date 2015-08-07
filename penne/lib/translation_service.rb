require 'google_translate'
require 'google_translate/result_parser'

# Provides a service to translate a given message to a given language.
class TranslationService
  FROM_LANG = 'en'

  attr_reader :translator

  def initialize(translator = GoogleTranslate.new)
    @translator = translator
  end

  def translate(message, language = nil)
    return message unless language

    fail UnsupportedLanguageError, "Sorry, #{language} is not supported." unless language_valid? language

    translation = translator.translate(FROM_LANG, language, message)
    ResultParser.new(translation).translation
  end

  private

  def language_valid?(language_code)
    _from_languages, to_languages = translator.supported_languages

    to_languages.select { |lang| lang.code == language_code }.nil?
  end

  # Describes an error encountered because a language supplied is not supported.
  class UnsupportedLanguageError < StandardError; end
end
