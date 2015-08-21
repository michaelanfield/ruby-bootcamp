# Contains helper functionality for the sky-bill application.
module Skybill
  # Provides a simple authentication method defaulting to a succesful login.
  module Auth
    def expect_to_be_on_login_page
      expect(page).to have_css 'input[name=username]'
      expect(page).to have_css 'input[name=password]'
      expect(page).to have_css 'button[type=submit]'

      expect(page).to have_content 'Login to your account'
    end

    def login(username: 'me@you.com', password: 'p455w0rd')
      within '#container form.login' do
        fill_in 'username', with: username
        fill_in 'password', with: password
      end

      click_button 'Login'
    end
  end
end
