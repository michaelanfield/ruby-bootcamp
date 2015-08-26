World(Module.new do
  def browser
    $browser ||= begin
      PageMagic.session(browser: :firefox).tap do |session|
        mappings = {}

        [LoginPage, BillPage].each do |page| 
          page.paths.each { |path| mappings[path] = page }
        end

        session.define_page_mappings(mappings)
      end
    end
  end

  def page
    browser.current_page
  end
end)