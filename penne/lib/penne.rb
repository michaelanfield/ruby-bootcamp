require_relative 'translation_service'

# Handles the translation of page text for display in a browser.
class Penne
  attr_reader :translation_service, :translate_to, :path

  def initialize
    @translation_service = TranslationService.new
  end

  def call(app)
    @translate_to = extract_translate_to_from_path_info(app['PATH_INFO'])

    [200, { 'Content-Type' => 'text/html; charset=utf-8' }, [translation_service.translate(body, translate_to)]]
  end

  def body
    fail NotImplementedError, 'You must implement the body'
  end

  private

  def extract_translate_to_from_path_info(path_info)
    path_info[/[^.]*$/] if path_info.include?('.')
  end
end
