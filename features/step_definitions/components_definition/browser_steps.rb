# encoding: UTF-8


 require 'capybara'
 require 'capybara/cucumber'
 require 'selenium-webdriver'

 #Selenium::WebDriver::Firefox::Binary.path = "C:\\Program Files (x86)\\Firefox Developer Edition\\firefox.exe"


# Select one browser to run the test
# 
# This step is required to run any test.
# It should be executed in Backgrond section.
# @param browser [String] Name of the browser using lowercase
 When /^I run "(.*?)"$/ do |navegador|
 	puts "1. Run '#{navegador}'."
 	if "#{navegador}" == "chrome"
		 Capybara.default_driver = :chrome
		 Capybara.register_driver :chrome do |app|
		 options = {
		 :js_errors => false,
		 :timeout => 360,
		 :debug => false,
		 :inspector => false,
		 }
		 Capybara::Selenium::Driver.new(app, :browser => :chrome)
		 end
	elsif "#{navegador}" == "firefox"
		 Capybara.default_driver = :firefox
		 Capybara.register_driver :firefox do |app|
		 options = {
		 :js_errors => true,
		 :timeout => 360,
		 :debug => false,
		 :inspector => false,
		 }
		 Capybara::Selenium::Driver.new(app, :browser => :firefox)
		 end
	elsif "#{navegador}" == "safari"
		 Capybara.default_driver = :safari
		 Capybara.register_driver :safari do |app|
		 options = {
		 :js_errors => false,
		 :timeout => 360,
		 :debug => false,
		 :inspector => false,
		 }
		 Capybara::Selenium::Driver.new(app, :browser => :safari)
		 end
	elsif "#{navegador}" == "opera"
		 Capybara.default_driver = :opera
		 Capybara.register_driver :opera do |app|
		 options = {
		 :js_errors => false,
		 :timeout => 360,
		 :debug => false,
		 :inspector => false,
		 }
		 Capybara::Selenium::Driver.new(app, :browser => :opera)
		 end
	elsif
		 Capybara.default_driver = :poltergeist
		 Capybara.register_driver :poltergeist do |app|
		 options = {
		 :js_errors => false,
		 :timeout => 360,
		 :debug => false,
		 :phantomjs_options => ['--load-images=no', '--disk-cache=false'],
		 :inspector => false,
		 }
		 Capybara::Poltergeist::Driver.new(app, options)
		 end
	end
	browser = Capybara.current_session.driver.browser
	browser.manage.window.maximize
 end


# Clear or delete browser cache
# 
# Get the actual browser and clear or delete cookies, it depends web driver.
When /^I clear browser cookies$/ do
	browser = Capybara.current_session.driver.browser
	puts "2. Clear browser cookies."
	if browser.respond_to?(:clear_cookies)
	  # Rack::MockSession
	  browser.clear_cookies
	elsif browser.respond_to?(:manage) and browser.manage.respond_to?(:delete_all_cookies)
	  # Selenium::WebDriver
	  browser.manage.delete_all_cookies
	else
	  raise "Don't know how to clear cookies. Weird driver?"
	end
	puts "- Cookies deleted"
end