require 'tty-prompt'

class User < ActiveRecord::Base
    has_many :games
    has_many :planets, through: :games
    @@prompt = TTY::Prompt.new
    

    def self.create_account
        @@prompt.say("Type exit to leave the program",color: :red)
        username = @@prompt.ask("Enter your full name i.e. LukeSkywalker")
            if username == "exit"
                exit
            end
        @@prompt.say("Type exit to leave the program",color: :red)
        while self.find_by(username: username) 
        username = @@prompt.ask("Username already taken. Please try again.")
            if username == "exit"
                exit
            end
        end
        password = @@prompt.mask("Create your password")
        self.create(username: username, password: password)
    end


    def self.login
        @@prompt.say("Type exit to leave the program",color: :red)
        username = @@prompt.ask("Enter username")
            if username == "exit"
                exit
            end         
        while self.find_by(username: username) == nil 
            username = @@prompt.ask("Username not found. Please try again")
            if username == "exit"
                exit
            end
        end
        password = @@prompt.mask("Enter password")
        while self.find_by(password: password) == nil
            password = @@prompt.mask("Incorrect password. Please try again")
        end
        self.find_by(username: username, password: password)
    end

    def self.delete_account(account)
        
        Game.all.select do |saved_game|   
           if account.id == saved_game.user_id
            Game.delete(saved_game.id)
         end
             self.delete(account.id)
        end
    end

end