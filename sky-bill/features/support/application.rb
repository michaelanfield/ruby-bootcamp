World(Module.new do
  def goto(page_path)
    visit "#{application_url}#{page_path}"
  end

  def login
    goto 'login'

    fill_in 'username', with: 'me@you.com'
    fill_in 'password', with: 'p455w0rd'
    click_button 'Login'
  end

        private

  def application_url
    "http://localhost:#{ENV['port'] || 9393}/"
  end
end)
