require 'tty-prompt'
require 'pry'

class Cli

attr_accessor :karma

@@user = nil
@@prompt = TTY::Prompt.new
@planet = nil
@planet_id = nil



        def display_menu
            # Displays the options to the user!
            system('clear')
            choices = { "Create an Account" => 1,
                    "Login" => 2,
                    "The Awakened" => 3,
                    "Exit" => 4    }
            action = @@prompt.select("What would you like to do?", choices)
            case action
            when 1  
                @@user = User.create_account
                self.game_menu
            when 2
                @@user = User.login
                # binding.pry
                self.game_menu
            when 3
                puts "Coming soon..."
            when 4
                system('exit')
        end
    end

    #====================================  
    #GAME MENU
    #====================================  


        def game_menu
            # Displays the options to the user!
            system('clear')
            choices = { "New Game" => 1,
                    "Delete Game" => 2,
                    "The Awakened" => 3,
                    "Exit" => 4}
            action = @@prompt.select("Awaken the Force", choices)
            case action
            when 1  
                @@prompt.say("Welcome, hero. Choose where to start your adventure")
                @@prompt.say("Light",color: :bright_blue)
                @@prompt.say("Dark",color: :red)
                
                 self.new_game
            when 2
                puts "coming soon.."
            when 3
                puts "Coming soon.."
                # Game.show_board
            when 4
                system('exit')
            end
        end

      def new_game
        choices = { "Tatooine" => 1,
                    "Alderaan" => 2,
                    "Exit" => 3}
       action = @@prompt.select("Select a planet",choices)
        case action
        when 1
            @@prompt.say("You have chosen Tatoonie",color: :yellow)
            self.tatooine
        when 2 
            @@prompt.say("You have chosen Alderaan",color: :green)
            self.alderaan
        when 3
            system('exit')
        end

      end

    #====================================  
    #STAGES / PLANETS
    #====================================  



        def tatooine
            @@prompt.say("Welcome to #{Planet.first.name}.\nPopulation: #{Planet.first.population.to_i}.\nTerrain: #{Planet.first.terrain}",color: :yellow)
            @@prompt.say("A band of ")
            @planet_id = Planet.first.id
            karma = 0

            
            choices_1 = { "Kill" => 1,
            "meditate" => 2,
            "run" => 3,
            "help" => 4}
            action_1 = @@prompt.select("A small band of child", choices_1)
            case action_1
            when 1
                karma += 2
            when 2
                karma -= 1
            when 3
                karma += 1
            when 4
                karma -= 2
            end
          
            choices_2 = { "Kill" => 1,
            "meditate" => 2,
            "run" => 3,
            "help" => 4}
            action_2 = @@prompt.select("A small band of child", choices_2)
            case action_1
            when 1
                karma -= 2
            when 2
                karma += 1
            when 3
                karma -= 1
            when 4
                karma += 2
            end
            binding.pry
            #Game.create(user_id: @@user.id,planet_id: @planet_id,karma: karma)

            



            
        end


        def alderaan
            @@prompt.say("Welcome to Tatonnie.\nPopulation: 200,000.\nTerrain: Desert")
            @planet = Planet.create_Alderaan
            @planet_id = @planet.id
        end






    end #Cli class

  
