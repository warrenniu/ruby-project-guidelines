class Games < ActiveRecord::Base
    has_many :results
    has_many :users, through: :results
    belongs_to :planet
end