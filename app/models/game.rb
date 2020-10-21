class Game < ActiveRecord::Base
    belongs_to :planet
    belongs_to :user

    @@prompt = TTY::Prompt.new


    # @username = nil
    # @results = nil
    # @planet = nil

     def self.show_tatooine
        @@sorted = self.all.sort_by {|saved_game| saved_game.user_id}
    
        @@sorted.each do |game|
            if game.planet_id == 1
                @@prompt.say ("#{game.user.username}  #{game.karma}")
               end
        end

            
    end


    




    

    # def calculate_karma
    #     if >= 5
    #         @@prompt.say("Jedi",color: :blue)
    #     else
    #         @@prompt.say("Sith",color: :red)
    #     end


  


end