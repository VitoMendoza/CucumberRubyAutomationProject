# encoding: UTF-8

# The file env.rb is used to define global setting parameters
#  
require 'capybara/cucumber'

Capybara.default_max_wait_time = 70

# Main URL 
BASE_URL = 'https://www.upwork.com'

# GLOBAL VARIABLES
#
# $pages contains all URLs 
$pages = Hash.new
  $pages['upwork'] = "#{BASE_URL}/"
  $pages['profilePage'] = "#{BASE_URL}/" + "o/profiles/users"

# $variables contains all variables used to keed data saved among the steps
$variables = Hash.new
	$variables['keyword'] = "" 
	$variables['freelancersList'] = Hash.new  