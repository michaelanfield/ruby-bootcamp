$LOAD_PATH.unshift("#{__dir__}/../../spec")
require 'support/views'

Bundler.require :development

Capybara.default_driver = :selenium
Capybara.default_selector = :css

module Helpers
  def without_resynchronize
    page.driver.options[:resynchronize] = false
    yield
    page.driver.options[:resynchronize] = true
  end
end

World(Helpers)
