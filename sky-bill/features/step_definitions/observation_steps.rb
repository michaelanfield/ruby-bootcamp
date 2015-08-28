Then(/^we will be on the (.*) page$/) do |page_name|
  expect(page.arrived).to be true
end

Then(/^the '(.*)' section content is hidden$/) do |section_name|
  expect(page.send(section_name.gsub(' ', '_')).breakdown).to_not be_visible
end 

Then(/^the '(.*)' section content is shown$/) do |section_name|
  expect(page.send(section_name.gsub(' ', '_')).breakdown).to be_visible
end

# Then(/^we will see '(.*)' at a cost of (£\d+\.\d+)$/) do |name, cost|
#   expect(page.packages.breakdown.subscriptions).to have_content name
#   expect(page.packages.breakdown.subscriptions).to have_content cost
# end
# 
# Then(/^we will see (.*) for a duration of (\d+:\d+:\d+) at a cost of (£\d+\.\d+)$/) do |phone_number, duration, cost|
#   expect(page.calls.breakdown.call_history).to have_content phone_number
#   expect(page.calls.breakdown.call_history).to have_content duration
#   expect(page.calls.breakdown.call_history).to have_content cost
# end
# 
# Then(/^we will see a '(.*)' group with (\d+) items and a title of '(.*)'$/) do |group_name, number_of_items, title|
#   group_name_selector = group_name.gsub(' ', '_')
# 
#   expect(page.sky_store.breakdown.send(group_name_selector).all('.store-item').size).to eq number_of_items.to_i
#   expect(page.sky_store.breakdown.send(group_name_selector).title.text).to eq title.upcase
# end
# 
# Then(/^the '(.*)' group will contain '(.*)' at a cost of (£\d+\.\d+)$/) do |group_name, text, cost|
#   group_text = page.sky_store.breakdown.send(group_name.gsub(' ', '_')).text
# 
#   expect(group_text).to include text
#   expect(group_text).to include cost
# end