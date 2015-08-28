require 'page_magic'

class LoginPage
  include PageMagic

  def self.paths; ['/login', '/']; end

  element :header_title, css: 'h1.header-title' 
  
  text_field :username, label: 'username'
  text_field :password, label: 'password'
  button :login_button, text: 'Login'

  def arrived; 'Sign in' == title; end

  def login username: 'me@you.com', password: 'p455w0rd'
    self.username.set username
    self.password.set password

    login_button.click
  end
end