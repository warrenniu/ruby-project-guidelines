require 'tty-prompt'

class User < ActiveRecord::Base
    has_many :results
    has_many :games, through: :results
    @@prompt = TTY::Prompt.new

    def self.create_account
        username = @@prompt.ask("Enter your full name i.e. LukeSkywalker")
        if username
            username = @@prompt.ask("Username already taken. Please try again")
        end
        password = @@prompt.mask("Create your password")
        self.create(username: username, password: password)
    end

    def self.login
        username = @@prompt.ask("Enter username")
        while self.find_by(username: username) == nil 
            username = @@prompt.ask("Username not found. Please try again")
        end
        password = @@prompt.mask("Enter password")
        while self.find_by(password: password) == nil
            password = @@prompt.mask("Incorrect password. Please try again")

        end
        self.find_by(username: username, password: password)
    end
end