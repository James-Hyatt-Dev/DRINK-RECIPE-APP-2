class CLI  

    def welcome
        puts ""
        puts "Welcome to our CLI Drink Recipe Application! We have over 600+ drinks, and 480+ ingrediates to share with you!"
        puts ""
        puts "If at any time you would like to exit the program, simply type in Q. "
        self.ask_for_drink_or_input
    end

  

    def ask_for_drink_or_input
        puts ""
        puts "Please make a selection to get started."
        puts ""
        puts "1. Choose from the top 10 drinks World Wide"
        puts "2. Select a liquor to find drinks and their recipes." 
        input = gets.strip
        self.input_from_step_1(input)
    end

    def input_from_step_1(input)
        if input == "1" || input.include?("choose") || input.include?("Choose") || input.include?("top") || input.include?("Top")
            top_ten_drinks
        elsif input == "2" || input.include?("recipe") || input.include?("Recipe") || input.include?("liquor") || input.include?("Liquor")
            request_from_liquor
        elsif input == "q" || input == "Q"
            user_quit
        else 
            puts "That selection was invalid, please select either 1 or 2."
            self.ask_for_drink_or_input
        end
    end

    def top_ten_drinks
        puts ""
        puts "1.  Mojito"    
        puts "2.  Old Fashioned"  
        puts "3.  Long Island Tea"    
        puts "4.  Negroni"    
        puts "5.  Mai Tai"
        puts "6.  Dry Martini"   
        puts "7.  Daiquiri"    
        puts "8.  Margarita"  
        puts "9.  Manhattan"  
        puts "10. Moscow Mule"
        puts ""
        puts "or... to search by liquor type, enter 'LIQUOR'"
        input = gets.strip
        self.user_input_drink(input) 
    end

    def user_input_drink(input)
        top_ten = {"1" => "Mojito", "2" => "Old Fashioned", "3" => "Long Island Tea", "4" => "Negroni", "5" => "Mai Tai", "6" => "Dry Martini", "7" => "Daiquiri", "8" => "Margarita", "9" => "Manhattan", "10" => "Moscow Mule"}
         if input == "1" || input == "mojito" || input == "Mojito" 
            new_recipe = Api.get_drink_by_name(top_ten["1"])
        elsif input == "2" || input == "old fashioned" || input == "Old fashioned" || input == "Old Fashioned" || input == "old" || input == "Old" 
            new_recipe = Api.get_drink_by_name(top_ten["2"])
        elsif input == "3" || input == "long island tea" || input == "Long island tea" || input == "Long Island Tea" || input == "long" || input == "Long" 
            new_recipe = Api.get_drink_by_name(top_ten["3"])
        elsif input == "4" || input == "negroni" || input == "Negroni" || input == "neg" || input == "Neg" || input == "negron" 
            new_recipe = Api.get_drink_by_name(top_ten["4"])
        elsif input == "5" || input == "Mai Tai" || input == "mai tai" || input == "Mai tai" || input == "Mai" || input == "mai" 
            new_recipe = Api.get_drink_by_name(top_ten["5"])
        elsif input == "6" || input == "dry martini" || input == "Dry Martini" || input == "Dry martini" || input == "Dry" || input == "dry" 
            new_recipe = Api.get_drink_by_name(top_ten["6"])
        elsif input == "8" || input == "margarita" || input == "Margarita" || input == "Marg" || input == "marg" || input == "margarit" 
            new_recipe = Api.get_drink_by_name(top_ten["8"])
        elsif input == "7" || input == "daiquiri" || input == "Daiquiri" || input == "Daquiri" || input == "daquiri" || input == "dag" 
            new_recipe = Api.get_drink_by_name(top_ten["7"])
        elsif input == "9" || input == "manhattan" || input == "Manhattan" || input == "manhatan" || input == "Manhatan" || input == "man" 
            new_recipe = Api.get_drink_by_name(top_ten["9"])
        elsif input == "10" || input == "moscow mule" || input == "Moscow Mule" || input == "Moscow mule" || input == "mule" || input == "mos" 
            new_recipe = Api.get_drink_by_name(top_ten["10"])
        elsif input == "LIQUOR" || input == "liquor" || input == "Liquor"
            request_from_liquor
        elsif input == "q" || input == "Q"
            user_quit
        else
            puts "Your input was invalid."
            self.ask_for_drink_or_input
        end
        self.recipe_display(new_recipe)
    end

    def recipe_display(new_recipe)
        puts "All the wonderful information you requested for your #{new_recipe.name} drink"
        puts ""
        puts "The recommended glass to use for your #{new_recipe.name} is the  #{new_recipe.glass}"
        puts ""
        puts "The ingredients and their  amounts to use are:"
        amounts_of_ingredients = new_recipe.ingredients.zip(new_recipe.amounts)
        amounts_of_ingredients.each do |ing, amt|
            puts "#{ing}: #{amt}"
        end
        puts ""
        puts "Now the best part! Time to make your drink!"
        puts ""
        puts "#{new_recipe.instructions}"
        main_menu
    end

    
########################################

    def request_from_liquor
        puts ""
        puts "Below is a list of 6 liquors/spirits"
        puts ""
        puts "Select from the choices below:"
        puts ""
        puts "1. Brandy"
        puts "2. Gin"
        puts "3. Rum"
        puts "4. Tequila"
        puts "5. Vodka"
        puts "6. Whisky"
        puts ""
        puts "or...to change your mind and search by the top 10 drinks in the world, type in 'TOP TEN'"
        input = gets.strip
        user_input_liquor(input)
    end

    def user_input_liquor(input)
        liquor_list = {"1" => "Brandy", "2" => "Gin", "3" => "Rum", "4" => "Tequila", "5" => "Vodka", "6" => "Whisky"}
        if input == "1"
            new_drink = Api.get_drink_by_liquor(liquor_list["1"])
        elsif input == "2"
            new_drink = Api.get_drink_by_liquor(liquor_list["2"])
        elsif input == "3"
            new_drink = Api.get_drink_by_liquor(liquor_list["3"])
        elsif input == "4"
            new_drink = Api.get_drink_by_liquor(liquor_list["4"])
        elsif input == "5"
            new_drink = Api.get_drink_by_liquor(liquor_list["5"])
        elsif input == "6"
            new_drink = Api.get_drink_by_liquor(liquor_list["6"])
        elsif input == "TOP TEN" || input == "top ten" || input == "Top ten" || input == "top Ten" || input == "Top Ten"
            top_ten_drinks
        elsif input == "q" || input == "Q"
            user_quit
        else
            puts "Your input was invalid"
            self.request_from_liquor
        end
        display_of_drinks(new_drink)
    end

    def display_of_drinks(new_drink)
        puts ""                                                                                                
        puts "Thank you, here is the list of drinks from your selection."
        puts ""
        puts "Please make a selection from the following list by entering  the correlating number."
        new_drink.each_with_index{|j,i| puts "#{i +1}. #{j.name}"}
        input = gets.strip
        input = input.to_i
            if (1..new_drink.count) === input
                input = new_drink[input-1].name  
                new_recipe = Api.get_drink_by_name(input)       
                self.recipe_display(new_recipe)
            elsif input == "q" || input == "Q"
                user_quit
            else 
                puts "Your input was invalid"
            end
        self.display_of_drinks(new_drink)
        end
    end





########################################

    def main_menu
        puts ""
        puts "If you wish to look up another recipe, please enter 1"
        puts ""
        puts "If you wish to exit the application, please enter 2"
        input = gets.strip
        if input == "1"
            self.ask_for_drink_or_input
        elsif input == "2" || input == "Q" || input == "q"
            self.exit_application
        else
            puts "Invalid Input"
            self.main.menu
        end
    def exit_application
        abort("Thank you for using our Drink Recipe Application! Have A Great Day!")
    end

    user_quit = exit_application 
    
end