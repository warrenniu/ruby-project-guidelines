class Game < ActiveRecord::Base
    belongs_to :planet
    belongs_to :user

    # @username = nil
    # @results = nil
    # @planet = nil

    def show_board
        self.all.each do |saved_games|
            
    end




    

    def calculate_karma
        if >= 5
            @@prompt.say("Jedi",color: :blue)
        else
            @@prompt.say("Sith",color: :red)
        end


  


end