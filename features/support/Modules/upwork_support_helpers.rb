# encoding: UTF-8

# Module for the group of functions for Upwork steps.
module UpworkSupportHelpers 


   # Search keyword in a given freelancer profile
   #
   # @param freelancer [Hash] Frelancer profile information 
   # @param keyword [String] Keyword to search
   # @return result [Boolean]
   # - true: [Boolean] Keyword was found
   # - false: [Boolean] Keyword was not found
    def verify_keyword(freelancer,keyword)

    	result = false

    	if freelancer["Name"].downcase().include? keyword.downcase().strip
    		result = true
    	end	

    	if freelancer["JobTitle"].downcase().include? keyword.downcase().strip
    		result = true
    	end

    	if freelancer["Overview"].downcase().include? keyword.downcase().strip
    		result = true
    	end

    	if freelancer["Country"].downcase().include? keyword.downcase().strip
    		result = true
    	end

      if freelancer["Skills"].downcase().include? keyword.downcase().strip
          result = true
      end

      if freelancer["Rate"].downcase().include? keyword.downcase().strip
          result = true
      end

      if freelancer["Earned"].downcase().include? keyword.downcase().strip
          result = true
      end

      if result
          freelancer["ContainsKeyword"] = true
      else
          freelancer["ContainsKeyword"] = false
      end
               
        return result
    end


   # Compare attributes between given freelancer profile and stored freelancer profiles.
   #
   # Using downcase() to efficiently compare the same text.
   # @param freelancersStored [Hash] Conteins 1..10 freelancer profiles
   # @param freelancerProfile [Hash] Given freelancer profile information
   # @return result [Boolean]
   # - true: [Boolean] The freelancer profile HAS coincidence
   # - false: [Boolean] The freelancer profile HAS NOT coincidence
    def compare_profile(freelancersStored, freelancerProfile)

        result = true
        i = 1
        while (i <= freelancersStored.length)
            result = true

            if !freelancerProfile["Name"].downcase().include? freelancersStored[i]["Name"].downcase().strip
                result = false
            end 

            if !freelancerProfile["JobTitle"].downcase().include? freelancersStored[i]["JobTitle"].downcase().strip
                result = false
            end

            if !freelancerProfile["Overview"].downcase().include? (freelancersStored[i]["Overview"].downcase().gsub("...", "").strip)
                result = false
            end

            if !freelancerProfile["Country"].downcase().include? freelancersStored[i]["Country"].downcase().strip
                result = false
            end

            if !freelancerProfile["Skills"].downcase().include? freelancersStored[i]["Skills"].downcase().strip
                result = false
            end

            if !freelancerProfile["Rate"].downcase().include? freelancersStored[i]["Rate"].downcase().strip
                result = false
            end

            if !freelancerProfile["Earned"].downcase().include? freelancersStored[i]["Earned"].downcase().strip
                result = false
            end

            if result
                 i = i + freelancersStored.length
            end 

            i = i + 1 

        end

        return result
    end


   # Simple method to merge strings from freelancer skills
   #
   # @param skills [String] Skill list
   # @param newSkill [String] New skill to be added to the Skill list
   # @return skills [String] Updated Skill list 
    def merge_skills(skills, newSkill)

        if newSkill!=""
            skills = skills + " " + newSkill 
        end

        return skills
    end
end

World(UpworkSupportHelpers)