require 'terminal-table'

class Game < ActiveRecord::Base
    belongs_to :planet
    belongs_to :user

    @@prompt = TTY::Prompt.new


    def self.show_tatooine
        system('clear')
        rows = []
        @@prompt.say("Displaying results for #{Planet.first.name}\n",color: :yellow)     
        self.sort_games_by_user_id.each do |game|
            if game.planet_id == 1
                rows << [game.user.username,game.karma]
            end
        end
        table = Terminal::Table.new :headings => ["Username","Title"],:rows => rows
        puts table
    end



    def self.show_alderaan
        system('clear')
        rows = []
        @@prompt.say("Displaying results for #{Planet.second.name}\n",color: :green)
        self.sort_games_by_user_id.each do |game|
            if game.planet_id == 2
                rows << [game.user.username,game.karma]
            end     
        end   
        table = Terminal::Table.new :headings => ["Username","Title"],:rows => rows
        puts table
    end    

    def self.show_naboo
        system('clear')
        rows = []
        @@prompt.say("Displaying results for #{Planet.third_to_last.name}\n",color: :green)
        self.sort_games_by_user_id.each do |game|
            if game.planet_id == 8
                rows << [game.user.username,game.karma]
            end     
        end   
        table = Terminal::Table.new :headings => ["Coming Soon.."],:rows => rows
        puts table
    end


    def self.show_all_results
        system('clear')
        rows = []
        @@prompt.say("Displaying all results")  
        self.sort_games_by_user_id.each do |game|
                rows << [game.user.username, game.karma, game.planet.name]
            end   
            table = Terminal::Table.new :headings => ["Username","Title","Planet"],:rows => rows
                puts table     
        end
        

    
    def self.sort_games_by_user_id
        self.all.sort_by {|saved_game| saved_game.user_id}

    end

        

end #end of game class