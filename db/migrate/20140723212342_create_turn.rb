class CreateTurn < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.integer :game_player_id
      t.integer :actions_left
      t.integer :buys_left
      t.integer :buying_power

      t.timestamps
    end
  end
end
