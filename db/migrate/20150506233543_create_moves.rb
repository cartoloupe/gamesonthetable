class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.references :users, index: true
      t.integer :number_of_moves

      t.timestamps null: false
    end
    add_foreign_key :moves, :users
  end
end
