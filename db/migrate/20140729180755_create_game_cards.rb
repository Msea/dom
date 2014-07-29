class CreateGameCards < ActiveRecord::Migration
  def change
    create_table :game_cards do |t|
      t.integer :card_id
      t.integer :game_id
      t.integer :stock, default: 10
      t.boolean :depleted?, default: false

      t.timestamps
    end
  end
end
