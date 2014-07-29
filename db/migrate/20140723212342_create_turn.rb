class CreateTurn < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.integer :game_player_id
      t.integer :actions_left, default: 1
      t.integer :buys_left, default: 1
      t.integer :buying_power, default: 0

      t.timestamps
    end
  end
end
