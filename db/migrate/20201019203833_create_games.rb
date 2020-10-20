class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :planet_id
      t.integer :user_id
      t.integer :karma
    end
  end
end
