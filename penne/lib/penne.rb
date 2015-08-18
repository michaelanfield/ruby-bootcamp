require_relative 'translation_service'

require 'slim'

# Handles the translation of page text for display in a browser.
class Penne
  attr_reader :translation_service

  def initialize
    @translation_service = TranslationService.new
  end

  def call(app)
    path_reference, translate_to = extract_path_and_language_from app['PATH_INFO']

    if path_valid? path_reference
      page_content = get_page_content_for path_reference

      [200, { 'Content-Type' => 'text/html; charset=utf-8' }, [translation_service.translate_page(page_content, translate_to)]]
    else
      [404, { 'Content-Type' => 'text/html; charset=utf-8' }, ['Page not found']]
    end
  end

  private

  class << self
    def page(path_reference, &block)
      pages[path_reference] = instance_eval(&block) if block_given?
    end

    def pages
      @pages ||= {}
    end

    def view(template)
      Slim::Template.new("views/#{template}.html.slim").render self
    end
  end

  def extract_path_and_language_from(path_info)
    path_and_language = [path_info, nil]

    if (matches = path_info.match(%r{^(?<path>[\w\.\/]+)\.(?<ext>\w+)$}))
      path_and_language = matches.captures
    end

    path_and_language
  end

  def get_page_content_for(path_reference)
    self.class.pages[path_reference]
  end

  def path_valid?(path_reference)
    self.class.pages.key? path_reference
  end
end
