class Planet < ActiveRecord::Base
    has_many :games
    has_many :users, through: :games


    def self.create_tatoonie
     self.create(name: "Tatoonie",population: 200000,terrain: "Desert")
    end

    def self.create_alderaan
        self.create(name: "Alderaan",population:2000000000,terrain: "Grasslands")
    end
   

   

end