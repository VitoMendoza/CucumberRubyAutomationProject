# encoding: UTF-8



# Step to choose Find Freelancers option in the search field.
# 
# Click on down arrow and click on Find Freelancers option.
When /^I chose Find Freelancers option$/ do
    begin
        find(:xpath, '//*[@id="visitor-nav"]/div[1]/form/div/div/div[2]/span').click
        find(:xpath, '//*[@id="visitor-nav"]/div[1]/form/div/ul/li[1]/a').click
    rescue Exception => e 
        puts " - Update this step." 
        puts e.message  
        puts e.backtrace.inspect
    end
end



# Step used to press enter in to search field.
# 
# ID for search field is defined as "q".
When /^I press enter to search freelancers$/ do
    find(:id, 'q').native.send_keys(:enter)
end



# Step made to get and save search results from search results page.
# 
# Getting and saving all attributes from the search results in $variables["freelancersList"].
When /^I save search results into a hash of hashes structure$/ do
    begin
        listLength = all(:xpath, "//*[@id='oContractorResults']/div/section").length
        step 'I waitfor 1 seconds'
        list = Hash.new
        if listLength>0

            # Getting all search results
            for i in 1..listLength

                # Getting freelancer one by one from the page
                freelancer = Hash.new
                freelancer["Name"] = find(:xpath, "//*[@id='oContractorResults']/div/section[#{i}]/div/article/div[2]/h4/a").text
                freelancer["JobTitle"] = find(:xpath, "//*[@id='oContractorResults']/div/section[#{i}]/div/article/div[2]/div[1]/h4").text
                freelancer["Overview"] = find(:xpath, "//*[@id='oContractorResults']/div/section[#{i}]/div/article/div[2]/div[3]/div/div/p").text
                freelancer["Country"] = find(:xpath, "//*[@id='oContractorResults']/div/section[#{i}]/div/article/div[2]/div[2]/div[4]/div/div/strong").text      

                # Getting all skills of each search result
                skillListLength = all(:xpath, "//*[@id='oContractorResults']/div/section[#{i}]/div/article/div[2]/span").length
                skills = ""
                if skillListLength>0
                    if skillListLength==1
                       skills = find(:xpath, "//*[@id='oContractorResults']/div/section[#{i}]/div/article/div[2]/span/a/span").text
                    else
                        for j in 1..skillListLength

                          # There is 4 different cases to get the skills
                          if all(:xpath, "//*[@id='oContractorResults']/div/section[4]/div/div/article/div[2]/div[4]/div/span[#{j}]/a/span/span").any?
                                newSkills = ""
                                newSkills = find(:xpath, "//*[@id='oContractorResults']/div/section[4]/div/div/article/div[2]/div[4]/div/span[#{j}]/a/span/span").text
                                skills = merge_skills(skills, newSkills)

                          elsif all(:xpath, "//*[@id='oContractorResults']/div/section[4]/div/div/article/div[2]/div[4]/div/span[#{j}]/a/span/span[1]").any?
                                newSkills = ""
                                newSkills = find(:xpath, "//*[@id='oContractorResults']/div/section[4]/div/div/article/div[2]/div[4]/div/span[#{j}]/a/span/span[1]").text
                                skills = merge_skills(skills, newSkills)

                          elsif all(:xpath, "//*[@id='oContractorResults']/div/section[#{i}]/div/article/div[2]/span[#{j}]/a/span[1]").any?
                                newSkills = ""
                                newSkills = find(:xpath, "//*[@id='oContractorResults']/div/section[#{i}]/div/article/div[2]/span[#{j}]/a/span[1]").text
                                skills = merge_skills(skills, newSkills)

                          else
                             newSkills = ""
                                newSkills = find(:xpath, "//*[@id='oContractorResults']/div/section[#{i}]/div/article/div[2]/span[#{j}]/a/span").text
                                skills = merge_skills(skills, newSkills)  
                               
                          end
                           
                        end

                    end
                end
                
                freelancer["Skills"] = skills
                freelancer["Rate"]  = find(:xpath, "//*[@id='oContractorResults']/div/section[#{i}]/div/article/div[2]/div[2]/div[1]/div/strong").text
                freelancer["Earned"] = find(:xpath, "//*[@id='oContractorResults']/div/section[#{i}]/div/article/div[2]/div[2]/div[2]/div/span/strong").text

                freelancer["ContainsKeyword"] = nil

                list[i] = freelancer
            end

            # Saving search results list
            $variables["freelancersList"] = list    
        end

    rescue Exception => e 
            puts " - Update this step." 
            puts e.message  
            puts e.backtrace.inspect
    end
end



# Step made to search the keywork in the search results. 
# 
# Create 2 Lists of results. Results which contains the keyword and results without the keyword.
# Both lists are saved in $variables.
When /^I search the keyword inthe search results$/ do
    begin
        # Structures to display results
        $variables['matchedFreelancer'] = Hash.new
        $variables['otherFreelancer'] = Hash.new 

        sizeList = $variables['freelancersList'].length
        indexMatched = 1
        indexUnmatched  = 1

        # Searching keyword in the freelancers list and saving results in the result lists
        for i in 1..sizeList
          if verify_keyword($variables['freelancersList'][i], $variables['keyword'])
             $variables['matchedFreelancer'].store(indexMatched, $variables['freelancersList'][i])    
             indexMatched = indexMatched + 1
          else
             $variables['otherFreelancer'].store(indexUnmatched, $variables['freelancersList'][i]) 
             indexUnmatched = indexUnmatched + 1
          end 
        end
    rescue  Exception => e 
        puts " - Update this step." 
        puts e.message  
        puts e.backtrace.inspect
    end

end



# Select random search result to get in
# 
# Generate a random number between 1 and search results length.
# Click on the element by random index.
When /I click on random search result$/ do
    begin
        selectedIndex = Random.new
        listLength = all(:xpath, "//*[@id='oContractorResults']/div/section").length
        textIndex = selectedIndex.rand(1..listLength)
        find(:xpath, "//*[@id='oContractorResults']/div/section[#{textIndex}]").click
    rescue Exception => e 
        puts " - Update this step." 
        puts e.message  
        puts e.backtrace.inspect
    end
end


 
# This step was made to compare the actual profile with the stored profiles from search results
#  
# Stored profiles should be saved in $variables["freelancersList"] and the actual browser page should be freelancer profile
# @return stdout text
# - true: Yes it is, the profile of #{name} contains the keyword '#{keyword}'.
# - false: This profile does not contains the keyword '#{keyword}'.
# - null: There's no saved data to compare.
When /^I compare each attribute of the actual profile with the stored profiles from search results$/ do
    begin
        freelancerProfile = Hash.new
        freelancerProfile["Name"] = find(:xpath, "//*[@id='optimizely-header-container-default']/div[1]/div[1]/div/div[2]/h2/span/span").text
        freelancerProfile["JobTitle"] = find(:xpath, "//*[@id='optimizely-header-container-default']/div[2]/div[1]/h3/span/span[1]").text
        freelancerProfile["Overview"] = find(:xpath, "//*[@id='optimizely-header-container-default']/div[2]/div[2]/o-profile-overview/div/p").text
        freelancerProfile["Country"] = find(:xpath, "//*[@id='optimizely-header-container-default']/div[1]/div[1]/div/div[2]/div/fe-profile-map/span/ng-transclude/strong[2]").text
        
        # Getting all skills from freelancer profile
        skillListLength = all(:xpath, '//*[@id="oProfilePage"]/div[1]/div/cfe-profile-skills-integration/div/div/section/div/up-skills-public-viewer/div/a').length
        skills = ""
        for i in 1..skillListLength
            newSkills = ""
            newSkills = find(:xpath, "//*[@id='oProfilePage']/div[1]/div/cfe-profile-skills-integration/div/div/section/div/up-skills-public-viewer/div/a[#{i}]").text
            skills = merge_skills(skills, newSkills)
        end
        freelancerProfile["Skills"] = skills

        # There is 2 different cases to get the Rate and Earned from the profile page
        if all(:xpath, "//*[@id='optimizely-header-container-default']/div[3]/ul/li[1]/div[1]/div/h3/cfe-profile-rate/span/span").any?
            freelancerProfile["Rate"] = find(:xpath, "//*[@id='optimizely-header-container-default']/div[3]/ul/li[1]/div[1]/div/h3/cfe-profile-rate/span/span", visible: false).text
            freelancerProfile["Earned"] = find(:xpath, "//*[@id='optimizely-header-container-default']/div[3]/ul/li[2]/h3/span", visible: false).text
        else
            freelancerProfile["Rate"] = find(:xpath, "//*[@id='optimizely-header-container-default']/div[4]/ul/li[1]/div[1]/div/h3/cfe-profile-rate/span/span", visible: false).text
            freelancerProfile["Earned"] = find(:xpath, "//*[@id='optimizely-header-container-default']/div[4]/ul/li[2]/h3/span", visible: false).text
        end
       
        freelancerProfile["ContainsKeyword"] = nil

        # Saving profile information in to $variables["FreelancerProfile"] to be use it later
        $variables["FreelancerProfile"] = freelancerProfile

        # Comparing actual profile and profiles from saved freelancersList
        if compare_profile($variables["freelancersList"], $variables["FreelancerProfile"] )
            puts "- Actual profile is EQUAL to one of the stored profiles."
        else
            puts "- Actual profile is NOT EQUAL to one of the stored profiles."
        end
    rescue Exception => e 
        puts " - Update this step." 
        puts e.message  
        puts e.backtrace.inspect
    end

end


 
# This step was made to search the keyword in the freelancer profile
#  
# @return stdout text
# - true: Yes it is, the profile of #{name} contains the keyword '#{keyword}'.
# - false: This profile does not contains the keyword '#{keyword}'.
# - null: There's no saved data to compare.
When /^I search the keyword inthe actual profile$/ do
    begin
        keyword = $variables['keyword']
        name = $variables["FreelancerProfile"]["Name"]
        # Searching keyword in $variables["FreelancerProfile"]
        if verify_keyword($variables["FreelancerProfile"], $variables['keyword'])
            puts "- Yes it is, the profile of #{name} contains the keyword '#{keyword}'."
        else
            puts "- This profile of #{name} does not contains the keyword '#{keyword}'."
        end
    rescue Exception => e 
        puts " - Update this step." 
        puts e.message  
        puts e.backtrace.inspect
    end
end

# ******************************************************************************************************************************************************