Then(/^we will be on the (.*) page$/) do |page_name|
  expect(page.arrived).to be true
end


