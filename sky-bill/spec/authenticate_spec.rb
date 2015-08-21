require 'spec_helper'

feature Authenticate do
  include_context :capybara_test
  include Skybill::Auth

  scenario 'Login with valid credentials' do
    visit '/'

    within '#container form.login' do
      fill_in 'username', with: 'me@you.com'
      fill_in 'password', with: 'p455w0rd'
    end

    click_button 'Login'

    expect(page).to have_content 'Your Bill'
  end

  scenario 'Login with invalid credentials' do
    visit '/'

    within '#container form.login' do
      fill_in 'username', with: 'me@you.com'
      fill_in 'password', with: 'incorrect'
    end

    click_button 'Login'

    expect(page).to have_css 'input[name=username]'
    expect(page).to have_content 'Login to your account'
  end

  scenario 'Access to bill directly should redirect to login' do
    visit '/bill'

    expect_to_be_on_login_page
  end

  scenario 'Once logged in you should be able to logout' do
    visit '/'
    login

    expect(page).to have_button 'Logout'

    click_button 'Logout'

    expect_to_be_on_login_page
  end
end
