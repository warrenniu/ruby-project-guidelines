require 'tty-prompt'
require 'tty-spinner'
require 'pry'
class Cli



@@user = nil
@@prompt = TTY::Prompt.new

@@arti = Artii::Base.new :font => 'slant'
@planet = nil
@planet_id = nil
@@title = nil

#animation variables
@@starwars = @@arti.asciify('Star Wars :')
@@awaken = @@arti.asciify('The Awaken')
@@spinner = TTY::Spinner.new("[:spinner] Now arriving....", format: :spin_4)
#end of animation variables

      


        def display_menu
            # Displays the options to the user!
            system('clear')
            @@prompt.say(@@starwars,color: :yellow)
            sleep(3)
            @@prompt.say(@@awaken,color: :yellow)
            
            choices = { "Create an Account" => 1,
                    "Login" => 2,
                    "The Awakened" => 3,
                    "Exit" => 4    }
            action = @@prompt.select("\nWelcome to Starwars: The Awaken! This is a decision based game. You will recieve a title depending on the decisions you make. \nWhat would you like to do?", choices)
            case action
            when 1  
                @@user = User.create_account
                self.game_menu
            when 2
                @@user = User.login
                # binding.pry
                self.game_menu
            when 3
                #when 3
                awakened_choices = {"Tatooine" => 1, "Alderaan" =>2, "Show all results" => 3,"Go back" => 4}
                awaken_action = @@prompt.select("Select planet to see results", awakened_choices)
                case awaken_action
                when 1 
                    Game.show_tatooine
                    choice = {"Go back" => 1}
                    action = @@prompt.select("", choice)
                    case action
                    when 1 
                    self.display_menu
                    end
                when 2
                    Game.show_alderaan
                    choice = {"Go back" => 1}
                    action = @@prompt.select("", choice)
                    case action
                    when 1 
                    self.display_menu
                    end
                when 3
                    Game.show_all_results
                        choice = {"Go back" => 1}
                        action = @@prompt.select("", choice)
                        case action
                        when 1 
                        self.display_menu
                         end
                when 4
                    self.display_menu
                end
                #end of when 3
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
                    "Go back" => 2}
                    @@prompt.say("Welcome, Hero")
            action = @@prompt.select("Awaken the Force", choices)
            case action
            when 1  
             
                 self.new_game
            when 2
                self.display_menu
            end
        end

      def new_game
        system('clear')
        @@prompt.say("Choose where to start your story")
        choices = { "Tatooine: Episodes I - III" => 1,
                    "Alderaan: Episodes IV - VI" => 2,
                    "Exit" => 3}
       action = @@prompt.select("Select a planet",choices)
        case action
        when 1
            self.check_tatooine
            @@prompt.say("You have chosen Tatooine",color: :yellow)
            self.tatooine
        when 2 
            @@prompt.say("You have chosen Alderaan",color: :green)
            self.alderaan
        when 3
            system('exit')
        end

      end



 



      def check_tatooine
        Game.all.each do |saved_game|
            if saved_game.user_id == @@user.id && saved_game.planet_id == Planet.first.id
                choices = { "Delete and start new game" => 1,
            "Go back" => 2}
            action = @@prompt.select("It looks like you already have a game" ,choices)
            case action
            when 1
                saved_game.destroy
                @@prompt.say("Game deleted")
                sleep(1.5)
            when 2
                self.game_menu
            end
        end
        end
    end
                

                
      


    #====================================  
    #STAGES / PLANETS
    #====================================  



        def tatooine
            @planet_id = Planet.first.id
            karma = 0

            system('clear')
            @@spinner.auto_spin
            sleep(5)
            @@spinner.stop
            system('clear')
            sleep(0.5)
            @@prompt.say("Welcome to #{Planet.first.name}.\nPopulation: #{Planet.first.population.to_i}.\nTerrain: #{Planet.first.terrain}\n",color: :yellow)
            
            sleep(3)
            @@prompt.say("Episode I: The Chosen One\n\n")
            @@prompt.say("Desolate. Corrupted. Poor. \nThe hero wakes up in a small mining village on a hot, muggy morning. \nLiving a life knowing nothing other than indentured servitude, the hero forces himself to step outside into the sweltering heat.\n\n")
            @@prompt.say("...Blood. The Stench. The Bodies. You couldn't help but put your hand over your mouth in horror. \nAs you scour the village, you suddenly hear a whimper of a voice calling for help. \nYou make your way over to the voice and noticed a woman, fatally injured, sitting on the floor, clenching a sleeping baby\n\n")
            @@prompt.say("'Please', says the woman. 'Take the baby and this note. The balance of the world is in your hands.'\nAs you take the baby and note, the woman reaches back out and begs for you to end her suffering\n\n")
           
            sleep(1)

            
            choices_1 = { "Kill the woman" => 1,
            "Leave the woman without saying a word" => 2,
            "Decline, and say that you cannot kill her" => 3,
            "Kill the woman, and take her belongings" => 4}
            action_1 = @@prompt.select("What will you do?", choices_1)
            case action_1
            when 1
                karma -= 1 
            when 2
                karma += 1
            when 3
                karma += 2
            when 4
                karma -= 2
            end
           
            system('clear')
            @@prompt.say("Episode II: The Chase\n")
           
            @@prompt.say("Hot. Tired. Helpless. \nThe hero walks through the endless deserts of Tatooine. 'The Chosen One'. That was all the note had written. \nThe hero holds the baby in his right arm and clenches the note in his left hand, dragging his feet through the sand.\n\n")
            @@prompt.say("Taking your last step before collapsing into the sand, you notice a shadowy figure in the distance, heading your way. \nAs you come to your senses, you suddenly find yourself strapped in the back of a bike with the baby, chased by two sandtroopers and a black cloak figure.\n\n" )
            @@prompt.say("With the chase intensifying, the driver is hit by a blast and the bike flips you and the baby into the sand\nAs you attempt to get up, you notice the black figure approaching you, holding a red light saber.\n\n")
            @@prompt.say("Frantically securing the baby, you noticed a blaster laying near you\n\n")
            sleep(1)

            choices_2 = { "Point the gun at the baby" => 1,
            "Leave the gun and attempt to run" => 2,
            "Point the gun at yourself" => 3,
            "Point the gun at black figure" => 4}
            action_2 = @@prompt.select("What will you do?", choices_2)
            case action_2
            when 1
                karma -= 2
            when 2
                karma += 1
            when 3
                karma -= 1
            when 4
                karma += 2
            end

            system('clear')
            @@prompt.say("Episode III: The Sacrifice\n")
            @@prompt.say("Suddenly, your body tightens up. You feel your fingers twitching, and your throat closing up as you're gasping for air. You feel your feet lifted from the ground\n\n")
            @@prompt.say("As the cloaked figure approaches, you recall the woman you encountered earlier in the day, and wondered if her last moments were similar to what you're feeling now\n\n")
            @@prompt.say("As you prepared for your death, you noticed that your savior had somehow secured the baby while your pursuer was focused on you. \nAs you glanced over, you felt the tension in your neck loosen as the dark figure noticed your savior escaping.\n\n") 
            @@prompt.say("You're able to regain full control of your body.\n\n")
            sleep(1)

            choices_3 = { "Run away" => 1,
            "Pick up the blaster" => 2,
            "Scream for help" => 3,
            "Tackle the dark figure" => 4}
            action_3 = @@prompt.select("What will you do?", choices_3)
            case action_2
            when 1
                karma -= 2
            when 2
                karma += 1
            when 3
                karma -= 1
            when 4
                karma += 2
            end
            system('clear')
            @@prompt.say("Your last desperate act was quickly noticed by your assailant and in a flash - you felt a sharp and hot pain through your abdominal, as if the Tatooine sun itself has found a way into your body. \nThe saber has pierced your abdominal.\n\n")
            @@prompt.say("You fall weightless to the ground, succumbing to the pain. You hear the bike roar to life and zoom away, and take a last glance at your killer. \nHood blown over by the wind, your killer was not a man nor a dark figure, but the red devil himself.\n\n")
            sleep(5)
            system('clear')

            @@spinner.auto_spin
            sleep(5)
            @@spinner.stop
            
            
            
            @@prompt.say("Welcome to #{Planet.fourth.name}.\nPopulation: #{Planet.fourth.population}.\nTerrain: #{Planet.fourth.terrain}\n\n",color: :bright_blue)
            sleep(3)
            @@prompt.say("10 years later...\n")
            @@prompt.say("Episode I: The Chosen One\n\n")
            @@prompt.say("Desolate. Corrupted. Poor. \nThe hero wakes up in a small mining village on a hot, muggy morning. \nLiving a life knowing nothing other than indentured servitude, the hero forces himself to step outside into the sweltering heat.\n\n")
            @@prompt.say("...Blood. The Stench. The Bodies. You couldn't help but put your hand over your mouth in horror. \nAs you scour the village, you suddenly hear a whimper of a voice calling for help. \nYou make your way over to the voice and noticed a woman, fatally injured, sitting on the floor, clenching a sleeping baby\n\n")
            @@prompt.say("'Please', says the woman. 'Take the baby and this note. The balance of the world is in your hands.'\nAs you take the baby and note, the woman reaches back out and begs for you to end her suffering\n\n")
            
            
            
            self.calculate_karma(karma, @@title)
            # binding.pry
            system('clear')
            @@prompt.say("Congratulations! You've attained the title, #{@@title}. Thank you for playing!")

            Game.create(user_id: @@user.id,planet_id: @planet_id,karma: @@title)
            # binding.pry
            sleep(5)

            self.game_menu
             

            
        end


        def alderaan
            karma = 0
            @planet_id = Planet.second.id

            system('clear')
            @@spinner.auto_spin
            sleep(5)
            @@spinner.stop
            system('clear')
            sleep(0.5)
            @@prompt.say("Welcome to #{Planet.second.name}.\nPopulation: #{Planet.second.population.to_i}.\nTerrain: #{Planet.second.terrain}",color: :green)
            sleep(3)
            @@prompt.say("Episode I: The Chosen One\n\n")
            @@prompt.say("Desolate. Corrupted. Poor. \nThe hero wakes up in a small mining village on a hot, muggy morning. \nLiving a life knowing nothing other than indentured servitude, the hero forces himself to step outside into the sweltering heat.\n\n")
            @@prompt.say("...Blood. The Stench. The Bodies. You couldn't help but put your hand over your mouth in horror. \nAs you scour the village, you suddenly hear a whimper of a voice calling for help. \nYou make your way over to the voice and noticed a woman, fatally injured, sitting on the floor, clenching a sleeping baby\n\n")
            @@prompt.say("'Please', says the woman. 'Take the baby and this note. The balance of the world is in your hands.'\nAs you take the baby and note, the woman reaches back out and begs for you to end her suffering\n\n")
           
            choices_1 = { "Kill the woman" => 1,
            "Leave the woman without saying a word" => 2,
            "Decline, and say that you cannot kill her" => 3,
            "Kill the woman, and take her belongings" => 4}
            action_1 = @@prompt.select("What will you do?", choices_1)
            case action_1
            when 1
                karma -= 1 
            when 2
                karma += 1
            when 3
                karma += 2
            when 4
                karma -= 2
            end

            self.calculate_karma(karma, @@title)
            # binding.pry
            system('clear')
            @@prompt.say("Congratulations! You've attained the title, #{@@title}. Thank you for playing!")

            Game.create(user_id: @@user.id,planet_id: @planet_id,karma: @@title)
            # binding.pry
            sleep(5)

            self.game_menu

        end






        def calculate_karma(points, title)
            if points >= 4
                @@title = "Jedi Master"
            elsif (0..3) === points
                @@title = "Jedi"
            elsif (-3..-1) === points 
                @@title = "Sith Apprentice"
            else
                @@title = "Sith Lord"
                # binding.pry
            end
        end






    end #Cli class

  
