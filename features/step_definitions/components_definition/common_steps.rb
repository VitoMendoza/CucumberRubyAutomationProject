# encoding: UTF-8

# Commons steps definition


# Search en input element and insert a value
#
# @param value [String] Value to insert
# @param field [String] Asociate text to the field (name or id)
When /^I insert "(.*?)" into "(.*?)" field$/ do |value, field|
  fill_in(field, with: value)
end

# Search the button given and click on it
#
# @param button_text [String] Asociate text to the button (id, name or value)
When /^I click on button "(.*?)"$/ do |button_text|
  click_on(button_text)
end

# Search the link given and click on it
#
# @param link_text [String] Asociate text to the link (id or alt)
When /^I click on link "(.*?)"$/ do |link_text|
  click_link(link_text)
end

# Stop the test execution for a while
# To secure the page was load correctly 
#
# @param seconds [Integer] Seconds for wait
When /^I waitfor (\d+) seconds$/ do |seconds|
  sleep(seconds.to_i)
end