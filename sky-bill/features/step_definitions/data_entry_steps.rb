Given(/^we supply a (.*) of (.*)$/) do |field_name, value|
  page.send(field_name).set value
end
