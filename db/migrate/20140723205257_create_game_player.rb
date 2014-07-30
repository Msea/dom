class CreateGamePlayer < ActiveRecord::Migration
  def change
    create_table :game_players do |t|
      t.integer :player_id
      t.integer :game_id
      t.integer :turn_order
      t.timestamps
      #chips for goons
    end
  end
end
