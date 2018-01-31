# language: en 
# encoding: UTF-8 

Feature: Find Freelancer
         Here we will test search function, search results

Background:
          # Insert your browser
          When I run "chrome"    
          And I clear browser cookies


# Test case: Fin Freelancer by search text
Scenario: Find Freelancer by search text
 
          When go to www.upwork.com
          And I select Find freelancers option
          
          # Insert your search text (keyword)
          When I insert "vito" into search field And press enter to search freelancers     
          And I save search results to compare
          Then I make sure at least one attribute from parsed search results contains the keyword. Go to stdout
          When I click on random freelancers title
          And I get into that freelancers profile
          And I check that each attribute value is equal to one of those stored inthe structure 
          Then I check whether at least one attribute contains the keywork