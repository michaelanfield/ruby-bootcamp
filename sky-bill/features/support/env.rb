require 'simplecov'

require_relative '../../spec/spec_helper'

Capybara.default_driver = :selenium
Capybara.default_selector = :css

module Helpers
  def without_resynchronize
    page.driver.options[:resynchronize] = false
    yield
    page.driver.options[:resynchronize] = true
  end
end

World(Capybara::DSL, Helpers)