# Provides a service to translate a given message to a given language.
class TranslationService
  def translate(message, _language = 'en')
    message
  end
end

# Represents the home page of the penne application.
class HomePage
  attr_reader :translation_service

  def initialize(translation_service = TranslationService.new)
    @translation_service = translation_service
  end

  def call(_app)
    [200, {}, translation_service.translate('Welcome to the next best thing!')]
  end
end
