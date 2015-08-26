World(Module.new do
  def goto(page_path, page: LoginPage)
    browser.visit page, url: "#{application_url}#{page_path}"
  end

  private

  def application_url
    "http://localhost:#{ENV['port'] || 9393}/"
  end
end)
