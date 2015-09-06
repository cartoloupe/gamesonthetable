class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :user, index: true
      t.belongs_to :game, index: true
      t.string :the_text
      t.datetime :the_time

      t.timestamps null: false
    end
    add_foreign_key :messages, :users
    add_foreign_key :messages, :games
  end
end
