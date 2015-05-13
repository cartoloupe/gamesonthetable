class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.references :user, index: true
      t.integer :number_of_moves

      t.timestamps null: false
    end
  end
end
