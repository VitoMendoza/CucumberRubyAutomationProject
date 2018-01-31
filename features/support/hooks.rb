# encoding: UTF-8

# File to define the actions to perform before and after each scenario

# Save the last page visited after execution test. 
After do
  page.save_screenshot()
end
