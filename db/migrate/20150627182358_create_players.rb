class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :comment
      t.references :user, index: true
      t.references :game, index: true

      t.timestamps null: false
    end
    add_foreign_key :players, :users
    add_foreign_key :players, :games

    change_table :moves do |t|
      t.references :player, index: true
    end

    add_foreign_key :moves, :players


  end
end
