require 'terminal-table'

class Game < ActiveRecord::Base
    belongs_to :planet
    belongs_to :user

    @@prompt = TTY::Prompt.new
    @@table 


    # @username = nil
    # @results = nil
    # @planet = nil


     def self.show_tatooine
        system('clear')
        rows = []
        @@sorted = self.all.sort_by {|saved_game| saved_game.user_id}
            @@prompt.say("Displaying results for #{Planet.first.name}\n",color: :yellow)     
        @@sorted.each do |game|
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
            @@sorted = self.all.sort_by {|saved_game| saved_game.user_id}
                 @@prompt.say("Displaying results for #{Planet.second.name}\n",color: :green)
            @@sorted.each do |game|
                if game.planet_id == 2
                    rows << [game.user.username,game.karma]
                end     
            end   
            table = Terminal::Table.new :headings => ["Username","Title"],:rows => rows
                puts table
        end    

        def self.show_all_results
            system('clear')
            rows = []
            @@sorted = self.all.sort_by {|saved_game| saved_game.user_id}
            @@prompt.say("Displaying all results")  
           
            @@sorted.each do |game|
                rows << [game.user.username, game.karma, game.planet.name]
            end   
            table = Terminal::Table.new :headings => ["Username","Title","Planet"],:rows => rows
                puts table     
        end

        

end #end of game class