class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :cost
      t.string :kind
      t.string :picture
      t.integer :stock

      t.timestamps
    end
  end
end
