Given(/^we are on the (\w+) page$/) do |page_name|
  goto page_name

  expect(page).to have_css 'input[name=username]'
  expect(page).to have_css 'input[name=password]'
  expect(page).to have_css 'button[type=submit]'

  expect(page).to have_content 'Login to your account'
end

When(/^we click the (.*) (.*)$/) do |click_target, target_type|
  click_button click_target
end