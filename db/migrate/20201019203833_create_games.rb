class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :planet_id
      t.integer :user_id
      t.string :karma
    end
  end
end
