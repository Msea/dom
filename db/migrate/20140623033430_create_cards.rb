class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :cost
      t.string :kind
      t.string :picture
      t.integer :stock #take this out later and do by type? change to default_stock? change to null unless exception?
      t.boolean :in_randomizer?
      t.string :expansion

      t.timestamps
    end
  end
end
