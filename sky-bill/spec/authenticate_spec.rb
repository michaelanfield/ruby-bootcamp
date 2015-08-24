require 'spec_helper'

feature Authenticate do
  include_context :capybara_test
  include Skybill::Auth

  # scenario 'Login with valid credentials' do
  #   visit '/'
# 
  #   login
# 
  #   expect(page).to have_content 'Your Bill'
  # end

  scenario 'Login with invalid credentials' do
    visit '/'

    login(password: 'incorrect')

    expect_to_be_on_login_page
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

  scenario 'Access via login should render the login page' do
    visit '/login'

    expect_to_be_on_login_page
  end
end
