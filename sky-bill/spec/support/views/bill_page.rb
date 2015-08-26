require 'page_magic'

class BillPage
  include PageMagic

  def self.paths; ['/bill']; end

  button :logout_button, text: 'Logout'

  def arrived; 'Your Bill' == title; end
end