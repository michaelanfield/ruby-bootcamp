Then(/^we will be on the bill page$/) do
  expect(page).to have_content 'Your Bill'
  expect(page).to have_button 'Logout'
end