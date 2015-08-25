Given(/^we supply a (.*) of (.*)$/) do |field_name, value|
  fill_in field_name, with: value
end
