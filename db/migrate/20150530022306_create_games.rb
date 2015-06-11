class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.datetime :end_time
      t.integer :num_users
      t.string :status

      t.timestamps null: false
    end
  end
end
