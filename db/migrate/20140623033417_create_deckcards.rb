class CreateDeckcards < ActiveRecord::Migration
  def change
    create_table :deckcards do |t|
      t.integer :player_id
      t.integer :card_id
      t.string :status  #lib, hand, discard, play, duration, inplay

      t.timestamps
    end
  end
end