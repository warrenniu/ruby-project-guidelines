require 'tty-prompt'
require 'tty-spinner'
require 'pry'

class Cli

#instance/class variables
@@user = nil
@@prompt = TTY::Prompt.new
@planet = nil
@planet_id = nil
@@title = nil
#end of instance/class variables

#animation variables
@@arti = Artii::Base.new :font => 'slant'
@@starwars = @@arti.asciify('Star Wars :')
@@awaken = @@arti.asciify('The Awaken')
@@spinner = TTY::Spinner.new("[:spinner] Now arriving....", format: :spin_4)
@@spinner_one = TTY::Spinner.new(":spinner] Performing action...", format: :spin_4)
@@pastel = Pastel.new
@@jedi_pastel = @@pastel.blue.bold("Jedi")
@@sith_pastel = @@pastel.red.bold("Sith")

#end of animation variables

    #====================================  
    #DISPLAY MENU
    #==================================== 


        def display_menu
            system('clear')
            sleep(5)
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
                self.game_menu
            when 3
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
              when 4
                system('exit')
            end
        end

    #====================================  
    #GAME MENU
    #====================================  


        def game_menu
            system('clear')
            choices = { "New Game" => 1,
                    "The Awakened" => 2,
                    "Go back" => 3}
            @@prompt.say("Welcome, Hero")
            action = @@prompt.select("Awaken the Force", choices)
            case action
            when 1  
                self.new_game
            when 2
                awakened_choices = {"Tatooine" => 1, "Alderaan" =>2, "Show all results" => 3,"Go back" => 4}
                awaken_action = @@prompt.select("Select planet to see results", awakened_choices)
                case awaken_action
                when 1 
                    Game.show_tatooine
                    choice = {"Go back" => 1}
                    action = @@prompt.select("", choice)
                    case action
                    when 1 
                    self.game_menu
                    end
                when 2
                    Game.show_alderaan
                    choice = {"Go back" => 1}
                    action = @@prompt.select("", choice)
                    case action
                    when 1 
                    self.game_menu
                    end
                when 3
                    Game.show_all_results
                    choice = {"Go back" => 1}
                    action = @@prompt.select("", choice)
                    case action
                    when 1 
                    self.game_menu
                    end
                when 4
                    self.game_menu
                end
            when 3
                self.display_menu

            end
        end

    #====================================  
    #NEW GAME
    #==================================== 


      def new_game
        system('clear')
        @@prompt.say("Choose where to start your story")
        choices = { "Tatooine" => 1,
                    "Alderaan" => 2,
                    "Exit" => 3}
        action = @@prompt.select("Select a planet",choices)
        case action
        when 1
            self.check_tatooine
            @@prompt.say("You have chosen Tatooine",color: :yellow)
            self.tatooine
        when 2 
            self.check_alderaan
            @@prompt.say("You have chosen Alderaan",color: :green)
            self.alderaan
        when 3
            system('exit')
        end

      end
                

                
      


    #====================================  
    #STAGES / PLANETS
    #====================================  


        #====================================  
        #TATOOINE
        #==================================== 

        def tatooine
            @planet_id = Planet.first.id
            karma = 0

            system('clear')
            self.now_arriving_spinner

            @@prompt.say("Welcome to #{Planet.first.name}.\nPopulation: #{Planet.first.population.to_i}.\nTerrain: #{Planet.first.terrain}\n",color: :yellow)
            
            #====================================  
            #TATOOINE - EPISODE I
            #==================================== 
            
            sleep(3)
            @@prompt.say("Episode I: The Chosen One\n\n")
            @@prompt.say("Desolate. Corrupted. Poor. \nThe hero wakes up in a small mining village on a hot, muggy morning. \nLiving a life knowing nothing other than indentured servitude, the hero forces himself to step outside into the sweltering heat.\n\n")
            @@prompt.say("...The Blood. The Stench. The Bodies. You couldn't help but put your hand over your mouth in horror. \nAs you scour the village, you suddenly hear a whimper of a voice calling for help. \nYou make your way over to the voice and noticed a woman, fatally injured, sitting on the floor, clenching a sleeping baby\n\n")
            @@prompt.say("'Please', says the woman. 'Take the baby and this note. The balance of the world is in your hands.'\nAs you take the baby and note, the woman reaches back out and begs for you to end her suffering\n\n")
            sleep(5)

            
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

            self.performing_action_spinner

            #====================================  
            #TATOOINE - EPISODE II
            #==================================== 
           
            system('clear')
            @@prompt.say("Episode II: The Chase\n\n")
           
            @@prompt.say("Hot. Tired. Helpless. \nThe hero walks through the endless deserts of Tatooine. 'The Chosen One'. That was all the note had written. \nThe hero holds the baby in his right arm and clenches the note in his left hand, dragging his feet through the sand.\n\n")
            @@prompt.say("Taking your last step before collapsing into the sand, you notice a shadowy figure in the distance, heading your way. \nAs you come to your senses, you suddenly find yourself strapped in the back of a speeder bike with the baby, chased by two sandtroopers and a black cloak figure.\n\n" )
            @@prompt.say("With the chase intensifying, the driver is hit by a blast and the bike flips you and the baby into the sand\nAs you attempt to get up, you notice the black figure approaching you, holding a red light saber.\n\n")
            @@prompt.say("Frantically securing the baby, you noticed a blaster laying near you\n\n")
            sleep(5)

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

            self.performing_action_spinner

            #====================================  
            #TATOOINE - EPISODE III
            #==================================== 

            system('clear')
            @@prompt.say("Episode III: The Sacrifice\n\n")
            @@prompt.say("Suddenly, your body tightens up. You feel your fingers twitching, and your throat closing up as you're gasping for air. You feel your feet lifted from the ground.\n\n")
            @@prompt.say("As the cloaked figure approaches, you recall the woman you encountered earlier in the day, and wondered if her last moments were similar to what you're feeling now.\n\n")
            @@prompt.say("As you prepare for your death, you notice that your savior had somehow secured the baby while your pursuer was focused on you. \nAs you glance over, you felt the tension in your neck loosen as the dark figure notices your savior escaping.\n\n") 
            @@prompt.say("You're able to regain full control of your body.\n\n")
            sleep(5)

            choices_3 = { "Run away" => 1,
            "Pick up the blaster" => 2,
            "Scream for help" => 3,
            "Tackle the dark figure" => 4}
            action_3 = @@prompt.select("What will you do?", choices_3)
            case action_3
            when 1
                karma -= 2
            when 2
                karma += 1
            when 3
                karma -= 1
            when 4
                karma += 2
            end

            self.performing_action_spinner

            system('clear')

            @@prompt.say("Your last desperate act was quickly noticed by your assailant and in a flash - you felt a sharp and hot pain through your abdominal, as if the Tatooine sun itself has found a way into your body. \nThe saber has pierced your abdominal.\n\n")
            @@prompt.say("You fall weightless to the ground, succumbing to the pain. You hear the bike roar to life and zoom away, and take a last glance at your killer. \nHood blown over by the wind, your killer was not a man nor a dark figure, but the red devil himself.\n\n")
            sleep(10)
            system('clear')

            self.now_arriving_spinner

            #====================================  
            #HOTH - EPISODE IV
            #==================================== 

            @@prompt.say("Welcome to #{Planet.fourth.name}.\nPopulation: #{Planet.fourth.population}.\nTerrain: #{Planet.fourth.terrain}\n",color: :bright_blue)

            sleep(3)
            @@prompt.say("15 years later...\n\n")
            sleep(3)
            
            @@prompt.say("Episode IV: The First Test\n\n")
            @@prompt.say("I believe you're ready\n\n")
            @@prompt.say("The master takes the boy across the frozen tundra of Hoth to a small clearing. As they crept towards the edge of the area, the boy sees a wild boar eating its dinner.\n\n'Remember what I taught you', says your master.'\n\n") 
            @@prompt.say("You close your eyes and take a deep breath. The warmth starts creeping up within you, soon reaching a boiling point.\nYou focus the energy into your hand as you lift it towards the animal. You open your eyes and release the energy towards the boar\n\n")
            @@prompt.say("The boar collapses, but it wasn't a clean kill. As you approach the wounded animal, you pull out your knife.\nGrabbing it with both hands as you were taught, you stand over the boar\n\n")
            sleep(5)

            choices_4 = { "Kill the boar, heartlessly and cold-blooded" => 1,
            "Kill the boar, emotion-less" => 2,
            "Do nothing, and watch the boar painfully die" => 3,
            "Kneel next to the boar, say a prayer, and kill the boar" => 4}
            action_4 = @@prompt.select("What will you do?", choices_4)
            case action_4
            when 1
                karma -= 2
            when 2
                karma += 1
            when 3
                karma -= 1
            when 4
                karma += 2
            end

            self.performing_action_spinner

            #====================================  
            #HOTH - EPISODE V
            #==================================== 

            system('clear')
            @@prompt.say("Episode V: The Second Encounter\n\n")
            @@prompt.say("You follow your master back to your camp, dragging your dinner behind you. As you're recounting your kill, your master suddenly puts his arm out, motioning you to stay low and stay quiet.\n\n")
            @@prompt.say("Stormtroopers. At least 20 of them, rummaging through the camp. You and your master slowly approach the camp, getting a closer look at the scene.\n\n")
            @@prompt.say("A branch snaps below your feet. Your heart drops and you felt your master tense up.\n\nThe stormtroopers look your way, and suddenly you're finding cover from a shower of blasters that were miraculously missing you\n\n")
            @@prompt.say("As you're hiding, you notice your master fighting off the stormtroopers with his lightsaber. Flowing like the wind, he was an artist. Your master wielding his green lightsaber and parrying all shots heading his way\n\n")
            @@prompt.say("Surveying the scene, you quickly notice a dark figure appear over the ledge of the camp. His hood blown off, his face reveals to be one like the red devil.\nIn mere seconds, the devil unsheathes his red lightsaber, jumps towards your master\n\n")
            @@prompt.say("You leap up with seconds to act.")
            sleep(5)

            choices_5 = { "Attempt to use the Force" => 1,
            "Do nothing and remain still" => 2,
            "Run towards your master" => 3,
            "Yell out in warning" => 4}
            action_5 = @@prompt.select("What will you do?", choices_5)
            case action_5
            when 1
                karma += 2
            when 2
                karma -= 2
            when 3
                karma -= 1
            when 4
                karma += 1
            end

            self.performing_action_spinner

            #====================================  
            #HOTH - EPISODE VI
            #==================================== 

            system('clear')
            @@prompt.say("Episode VI: Darth Maul\n\n")
            @@prompt.say("You blink, and it's over. What seemed like an art piece just a few seconds ago had evaporated\n\n")
            @@prompt.say("The assailant struck a clean bow. The green lightsaber falls onto the snowy terrain, and your master coughs up droplets of blood. The assailant pulls his lightsaber out of your master's body and his lifeless body falls into the snow\n\n")
            @@prompt.say("You freeze. The tundra of Hoth doesn't feel cold anymore. The memories of your master starts flowing through your mind. The only person you've ever known in your life, gone.\n\n")
            @@prompt.say("The black figure starts heading towards you while the stormtroopers head towards your slain master.\nAs he approaches, you can't help but feel a sense of deja vu, as if you've lived through this moment before\n\n")
            @@prompt.say("The devil creeps closer, about twelve feet from you.\n\n")
            sleep(5)
           

            choices_6 = { "Attempt to use the Force" => 1,
            "Do nothing and remain still" => 2,
            "Pick up snow and throw it at him" => 3,
            "Attempt to run away" => 4}
            action_6 = @@prompt.select("What will you do?", choices_6)
            case action_6
            when 1
                karma += 2
            when 2
                karma -= 1
            when 3
                karma += 1
            when 4
                karma -= 2
            end

            self.performing_action_spinner

            system('clear')
            @@prompt.say("As you make make your move, you feel your body tighten up and your arms locked to your side, You feel your throat closing as you're suddenly gasping for air. Your body being lifted into the air")
            @@prompt.say("The black figure stands before you, watching you struggle. When you feel like you couldn't take another breath, the assailant hits you hard behind your next, knocking you unconscious.")
            sleep(10)
            system('clear')

           self.now_arriving_spinner

            #====================================  
            #CORUSCANT - EPISODE VII
            #==================================== 

            @@prompt.say("Welcome to #{Planet.second_to_last.name}.\nPopulation: #{Planet.second_to_last.population}.\nTerrain: #{Planet.second_to_last.terrain}\n",color: :red)

            sleep(3)
            @@prompt.say("5 years later...\n\n")
            sleep(3)
            
            @@prompt.say("Episode VII: A Sea of Flames\n\n")
            @@prompt.say("Fire. A sea of flames as far as the eyes can see.\n\n")
            @@prompt.say("Coruscant is burning. Skyscrapers that once stood tall are falling one by one. Screams from civilians and soldiers fighting can be heard from far below. The Sith is descending towards the Jedi Temple.'\n\n") 
            @@prompt.say("As you make your way towards the Temple, standing next to your lord, Darth Maul, you feel a tingling sensation throughout your body.\nThe Force has enveloped your body, but the feeling is different than it was 5 years ago when you first learned to harness the power.\n\n")
            @@prompt.say("Your ship docks on a landing pad at the Temple as you and your comrades disembark the ship. You're met with a handful of Jedi putting up a resistance and the Sith soon engages.\n\n")
            sleep(5)

            choices_7 = { "Do nothing and stand in the back" => 1,
            "Take out your lightsaber and start engaging the Jedi" => 2,
            "Charge up your lightning but don't use it" => 3,
            "Use the Force and choke them all to death" => 4}
            action_7 = @@prompt.select("What will you do?", choices_7)
            case action_7
            when 1
                karma += 2
            when 2
                karma -= 1
            when 3
                karma += 1
            when 4
                karma -= 2
            end
            self.performing_action_spinner
            
            
            #=========================================  
            #TATOOINE - END OF GAME KARMA CALCULATION
            #========================================= 
            
            
            self.calculate_karma(karma, @@title)
            system('clear')
            @@prompt.say("Congratulations! You've attained the title, #{@@title}. Thank you for playing!")

            Game.create(user_id: @@user.id,planet_id: @planet_id,karma: @@title)
            sleep(5)

            self.game_menu
             

            
        end #END OF TATOOINE

        #====================================  
        #ALDERAAN 
        #==================================== 

        def alderaan
            karma = 0
            @planet_id = Planet.second.id

            system('clear')

            self.now_arriving_spinner

            #====================================  
            #ALDERAAN - EPISODE I
            #==================================== 

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

            #=========================================  
            #ALDERAAN - END OF GAME KARMA CALCULATION
            #========================================= 

            self.calculate_karma(karma, @@title)
            system('clear')
            @@prompt.say("Congratulations! You've attained the title, #{@@title}. Thank you for playing!")

            Game.create(user_id: @@user.id,planet_id: @planet_id,karma: @@title)
            sleep(5)

            self.game_menu

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

          def check_alderaan
            Game.all.each do |saved_game|
                if saved_game.user_id == @@user.id && saved_game.planet_id == Planet.second.id
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

        #=========================================  
        #SPINNER METHODS
        #========================================= 
        


        def now_arriving_spinner
            @@spinner.auto_spin
            sleep(5)
            @@spinner.stop
            system('clear')
            sleep(0.5)
        end

        def performing_action_spinner
            @@spinner_one.auto_spin
            sleep(3)
            @@spinner_one.stop
            @@prompt.say("Action Performed")
            sleep(1)
        end

        #=========================================  
        #CALCULATE KARMA METHODS
        #========================================= 

        
        def calculate_karma(points, title)
            if points >= 4
                @@title = "Jedi Master"
            elsif (0..3) === points
                @@title = "Jedi"
            elsif (-3..-1) === points 
                @@title = "Sith Apprentice"
            else
                @@title = "Sith Lord"
            end
        end
        def calculate_karma(points, title)
            if points >= 4
                @@title = @@jedi_pastel
            else
                @@title = @@sith_pastel
            end
        end






    end #End of Cli class

  
