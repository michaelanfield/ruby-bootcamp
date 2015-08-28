Given(/^we are on the (\w+) page$/) do |page_name|
  goto page_name

  expect(page.arrived).to be true
end

Given(/^we are logged in$/) do
  goto 'login'
  
  page.login
end

Given(/^we are not logged in$/) do
  goto 'logout'
end

When(/^we navigate to the (.*) page$/) do |page_name|
  goto page_name, page: eval("#{page_name.capitalize}Page")
end

When(/^we click the '(.*)' (.*)$/) do |click_target, target_type|
  page.send("#{click_target.gsub(' ', '_')}_#{target_type}").click
end
