Then(/^we will be on the (.*) page$/) do |page_name|
  expect(page.arrived).to be true
end

Then(/^we will see '(.*)' at a cost of (£\d+\.\d+)$/) do |name, cost|
  expect(page.packages.breakdown.subscriptions).to have_content name
  expect(page.packages.breakdown.subscriptions).to have_content cost
end

Then(/^we will see (.*) for a duration of (\d+:\d+:\d+) at a cost of (£\d+\.\d+)$/) do |phone_number, duration, cost|
  expect(page.calls.breakdown.call_history).to have_content phone_number
  expect(page.calls.breakdown.call_history).to have_content duration
  expect(page.calls.breakdown.call_history).to have_content cost
end