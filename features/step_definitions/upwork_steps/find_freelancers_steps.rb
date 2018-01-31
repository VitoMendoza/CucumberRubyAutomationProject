# encoding: UTF-8


# Use steps from upwork_steps.rb
# Use steps from commons_steps.rb



# Step 3
# 
# Navigate to upwork site web. 
# The URL is taken from a global variable $pages. It's declared in env.rb file
# Log action.
Given /^go to www.upwork.com$/ do 
	puts "3. Go to www.upwork.com."
    visit $pages['upwork']
end

# Step 4
# 
# Focus on to Find Freelancers option.
# Log action.
When /^I select Find freelancers option$/ do
	puts "4. Focus onto 'Find freelancers'."
    step 'I chose Find Freelancers option'
end 

# Step 5
# 
# Insert keyword to search and submit. 
# I save the keyword in a global variable to use later.
# Log action.
When /^I insert "(.*?)" into search field And press enter to search freelancers$/ do |value|
    puts "5. Insert '#{value}' into the search input right from the dropdown and submit it (press enter)."
	step 'I insert "'"#{value}"'" into "q" field'
    $variables['keyword'] = value
    step 'I press enter to search freelancers'
end

# Step 6
# 
# I store info given on the 1st page of search results as structured data 
# Log action.
When /^I save search results to compare$/ do
    puts "6. Save search results to compare."
    step 'I save search results into a hash of hashes structure'
    step 'I waitfor 1 seconds'
end

# Step 7
# 
# Make sure at least one attribute (title, overview, skills, etc) of each item (found freelancer) from parsed search results contains `<keyword>` 
# Log action.
# Log in stdout which freelancers and attributes contain `<keyword>` and which do not
When /^I make sure at least one attribute from parsed search results contains the keyword. Go to stdout$/ do
    step 'I waitfor 1 seconds'
    puts "7. Make sure at least one attribute (title, overview, skills, etc) of each item (found freelancer) from parsed search results contains `<keyword>` Log in stdout which freelancers and attributes contain `<keyword>` and which do not."
    step 'I search the keyword inthe search results'
    puts "****** Freelancers MATCHED with search text '#{$variables['keyword']}' ******"
    puts JSON.pretty_generate($variables['matchedFreelancer'])
    puts "--------------------------------------------------"

    puts "****** Freelancers UNMATCHED with search text '#{$variables['keyword']}' ******"
    puts JSON.pretty_generate($variables['otherFreelancer'])
    puts "--------------------------------------------------"
end

# Step 8
# 
# Click on random freelancer title to get in
# Log action.
When /^I click on random freelancers title$/ do
    puts "8. Click on random freelancer's title."
    step 'I click on random search result'
    step 'I waitfor 1 seconds'
end

# Step 9
# 
# Expect to get in to freelancer's profile
# Log action.
When /^I get into that freelancers profile$/ do
    if current_url.include? $pages['profilePage']
        puts "9. Get into that freelancer's profile."
    else
        puts "9. Get into that freelancer's profile. But url has changes."
    end
end

# Step 10
# 
# Compare attributes of the actual profile to one of those stored inthe structure
# Log action.
When /^I check that each attribute value is equal to one of those stored inthe structure$/ do
    puts "10. Check that each attribute value is equal to one of those stored inthe structure."
    step 'I waitfor 1 seconds'
    step 'I compare each attribute of the actual profile with the stored profiles from search results'
end

# Step 11
# 
# Search the keyword in the actual profile
# Log action.
When /^I check whether at least one attribute contains the keywork$/ do
    puts "11. I check whether at least one attribute contains the keyword."
    step 'I waitfor 1 seconds'
    step 'I search the keyword inthe actual profile'  
    puts '- Test Finished Successfully!' 
end