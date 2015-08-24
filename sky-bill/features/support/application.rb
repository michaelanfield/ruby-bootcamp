World(Module.new do

  def goto page_path
    visit "#{application_url}#{page_path}"
  end

  private 

  def application_url
    "http://localhost:#{ENV['port'] || 9292}/"
  end
end)