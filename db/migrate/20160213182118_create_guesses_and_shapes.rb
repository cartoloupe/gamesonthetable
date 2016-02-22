class CreateGuessesAndShapes < ActiveRecord::Migration
  def up
    create_table :guesses do |t|
      t.integer :player_id, :null => false
    end

    create_table :shapes do |t|
      t.float :x
      t.float :y
      t.string :shape_type
      t.float :radius
      t.string :color
      t.integer :guess_id, :null => false
    end

    add_index :shapes, :guess_id, name: "index_shapes_on_guess_id"
    add_index :guesses, :player_id, name: "index_guesses_on_player_id"
  end

  def down
    drop_table :guesses
    drop_table :shapes
  end
end
