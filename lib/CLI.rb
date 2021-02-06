class CLI  

    def welcome_user
        puts ""
        puts "Welcome to our CLI Drink Recipe Application! We have over 600+ drinks, and 480+ ingrediates to share with you!".colorize(:light_blue)
        puts ""
        puts "If at any time you would like to exit the program, simply type in Q. ".colorize(:light_blue)
        self.prompt_for_drink_or_liquor
      
    end

  

    def prompt_for_drink_or_liquor
        puts ""
        puts "Please make a selection to get started.".colorize(:green)
        puts ""
        puts "1. Choose from the top 10 drinks World Wide".colorize(:yellow)
        puts "2. Select a liquor to find drinks and their recipes.".colorize(:yellow)
        input = gets.strip
        self.input_from_prompt_for_drink_or_liquor(input)
    end

    def input_from_prompt_for_drink_or_liquor(input)
        if input == "1" || input.include?("choose") || input.include?("Choose") || input.include?("top") || input.include?("Top")
            display_top_ten_drinks
        elsif input == "2" || input.include?("recipe") || input.include?("Recipe") || input.include?("liquor") || input.include?("Liquor")
             display_of_liquors
        elsif input == "q" || input == "Q"
            self.exit_application
        else 
            puts "That selection was invalid, please select either 1 or 2.".colorize(:red)
            self.prompt_for_drink_or_liquor
        end
    end

    def display_top_ten_drinks
        rows = []
        rows << ['1', 'Mojito']
        rows << ['2', 'Old Fashioned']
        rows << ['3', 'Long Island Tea']
        rows << ['4', 'Negroni']
        rows << ['5', 'Mai Tai']
        rows << ['6', 'Dry Martini']
        rows << ['7', 'Daiquiri']
        rows << ['8', 'Margarita']
        rows << ['9', 'Manhattan']
        rows << ['10', 'Moscow Mule']
        rows << ['11'.colorize(:red), 'Search by liquor'.colorize(:red)]
        table = Terminal::Table.new :title => "Top Ten Drinks World Wide".colorize(:green), :headings => ['Enter'.colorize(:yellow), 'For Drink'.colorize(:yellow)], :rows => rows
        puts table
        input = gets.strip
        self.user_selection_of_display_top_ten_drinks(input) 
    end

    def user_selection_of_display_top_ten_drinks(input)
        top_ten = {"1" => "Mojito", "2" => "Old Fashioned", "3" => "Long Island Tea", "4" => "Negroni", "5" => "Mai Tai", "6" => "Dry Martini", "7" => "Daiquiri", "8" => "Margarita", "9" => "Manhattan", "10" => "Moscow Mule"}
        input_value = top_ten[(input)]
        if input.to_i.between?(1,10) 
            new_recipe = Api.get_drink_by_name(input_value)
        elsif input == "q" || input == "Q" || input == "End" || input == "end"
            exit_program
        elsif input == "11" || input == "liquor" || input == "Liquor" || input == "start ovr"
             display_of_liquors
        else
            puts "Your input was invalid.".colorize(:red)
            self.prompt_for_drink_or_liquor
        end
        self.recipe_display(new_recipe)
    end

    def recipe_display(new_recipe)
        puts "All the wonderful information you requested for your".colorize(:green) + " #{new_recipe.name.colorize(:yellow)}" + " drink.".colorize(:green)
        amounts_of_ingredients = new_recipe.ingredients.zip(new_recipe.amounts)
        puts "The recommended glass to use for your".colorize(:green) +  " #{new_recipe.name.colorize(:yellow)}" + ", is the".colorize(:green) + " #{new_recipe.glass.colorize(:yellow)}" + ".".colorize(:green)
        puts "The ingredients and their amounts to use are:".colorize(:green)
        puts ""
        amounts_of_ingredients = new_recipe.ingredients.zip(new_recipe.amounts)
        amounts_of_ingredients.each do |ing, amt|
            puts "#{ing}:".colorize(:yellow) + " #{amt}" 
        end
        puts ""
        puts "Now the best part! Time to make your drink!".colorize(:green)
        puts ""
        puts "#{new_recipe.instructions}".colorize(:yellow)
        self.cli_main_menu

    end

    def display_of_liquors
        rows = []
        rows << ['1', 'Brandy']
        rows << ['2', 'Gin']
        rows << ['3', 'Rum']
        rows << ['4', 'Tequila']
        rows << ['5', 'Vodka']
        rows << ['6', 'Whisky']
        rows << ['7'.colorize(:red), 'Search by Top Ten Drinks'.colorize(:blue)]
        table = Terminal::Table.new :title => "Top 6 Spirits World wide ".colorize(:green), :headings => ['Option'.colorize(:yellow), 'Spirit'.colorize(:yellow)], :rows => rows
        puts table
        input = gets.strip
        self.user_selection_from_display_of_liquors(input)
    end

    def user_selection_from_display_of_liquors(input)
       
        liquor_list = {"1" => "Brandy", "2" => "Gin", "3" => "Rum", "4" => "Tequila", "5" => "Vodka", "6" => "Whisky"}
        input_value2 = liquor_list[(input)]
        if input.to_i.between?(1,6) 
            new_drink = Api.get_drink_by_liquor(input_value2)
        elsif input == "q" || input == "Q"
            self.user_quit
        elsif input == "7" || input == "search" || input == "start over" || input == "top ten" || input == "Top Ten" || input == "Top ten"
            self.display_top_ten_drinks
        else
            puts "Your input was invalid".colorize(:red)
            self. display_of_liquors
        end
        display_of_drinks(new_drink)
    end
#####
    def display_of_drinks(new_drink)
        puts ""                                                                                                
        puts "Thank you, here is the list of drinks from your selection.".colorize(:green)
        puts ""
        puts "Please make a selection from the following list by entering  the correlating number.".colorize(:yellow)
        rows = []
        new_drink.each_with_index do |j,i| 
            rows << ["#{i +1}", "#{j.name}"]
        end
        table = Terminal::Table.new :title => "Our list of drinks for".colorize(:green) + " #{new_drink[0].liquor}".colorize(:green), :headings => ['Enter'.colorize(:yellow), 'For Drink'.colorize(:yellow)], :rows => rows
        
        puts table        
        input = gets.strip
        input = input.to_i
            if (1..new_drink.count) === input
                input = new_drink[input-1].name  
                new_recipe = Api.get_drink_by_name(input)  
                self.recipe_display(new_recipe)
            elsif input == "q" || input == "Q"
                user_quit
            else 
                puts "Your input was invalid".colorize(:red)
            end
            self.display_of_drinks(new_drink)
        
    end
####
    def cli_main_menu
        puts ""
        puts "If you wish to look up another recipe, please enter 1".colorize(:green)
        puts ""
        puts "If you wish to exit the application, please enter 2".colorize(:red)
        input = gets.strip
        if input == "1"
            self.prompt_for_drink_or_liquor
        elsif input == "2" || input == "Q" || input == "q"
            self.exit_application
        else
            puts "Invalid Input".colorize(:red)
        end
        self.cli_main_menu

    end

    def exit_application
        abort("Thank you for using our Drink Recipe Application! Have A Great Day!".colorize(:green))
    end
end

