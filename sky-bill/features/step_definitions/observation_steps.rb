Then(/^we will be on the bill page$/) do
  expect(page).to have_content 'Your Bill'
  expect(page).to have_button 'Logout'
end

Then(/^we will be on the login page$/) do
  expect(page).to have_css 'input[name=username]'
  expect(page).to have_css 'input[name=password]'
  expect(page).to have_css 'button[type=submit]'

  expect(page).to have_content 'Login to your account'
end