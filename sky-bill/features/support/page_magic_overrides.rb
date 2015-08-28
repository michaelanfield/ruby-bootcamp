# Library to model fields on a page.
module PageMagic

  # Represents a page element.
  class Element
    # Adds the respond_to? method so that we can utilise to rspec matchers.
    def respond_to? method_name
      @browser_element.respond_to?(method_name)
    end
  end
end