class CreateDeckcards < ActiveRecord::Migration
  def change
    create_table :deckcards do |t|
      t.integer :game_player_id
      t.integer :card_id
      t.string :status  #lib, hand, discard, play, duration, inplay
      t.integer :library_position

      t.timestamps
    end
  end
end