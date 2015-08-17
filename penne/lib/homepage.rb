require_relative 'translation_service'

# Represents the home page of the penne application.
class HomePage
  attr_reader :translation_service, :translate_to

  def initialize(translation_service = TranslationService.new)
    @translation_service = translation_service
  end

  def call(app)
    @translate_to = extract_translate_to_from_path_info(app['PATH_INFO'])

    [200, { 'Content-Type' => 'text/html; charset=utf-8' }, [translation_service.translate('Welcome to the next best thing!', translate_to)]]
  end

  private

  def extract_translate_to_from_path_info(path_info)
    path_info[/[^.]*$/] if path_info.include?('.')
  end
end
