require 'tty-prompt'
require 'pry'

class Cli

@@user = nil
@@prompt = TTY::Prompt.new

# action = @@prompt.select("What would you like to do?", choices)

        def display_menu
            # Displays the options to the user!
            system('clear')
            choices = { "Create an Account" => 1,
                    "Login" => 2,
                    "The Awakened" => 3,
                    "Exit" => 4,
                    # "Select from all categories" => 5
                }
            action = @@prompt.select("What would you like to do?", choices)
            case action
            when 1  
                @@user = User.create_account
                binding.pry
                # random_cat = Category.all.sample # gets random category from those seeded
                # api_data = self.get_category_data(random_cat) # uses helper method to get clues from API
                # self.play_game(random_cat.id, api_data) # plays the game!
            when 2
                @@user = User.login
                # binding.pry
            when 3
                puts "You chose to see results"
            when 4
                puts "You chose to see your game results"
            when 5 # Select from all categories
                chosen_category = self.choose_category # uses helper method to display and get category choice
                api_data = self.get_category_data(chosen_category) # uses helper method to get clues from API
                self.play_game(chosen_category.id, api_data) # plays the game!
            end
        end

    end #Cli class

  
