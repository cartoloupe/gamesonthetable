class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :secs_left
      t.integer :num_users
      t.boolean :open
      t.integer :status_cd
      
      t.timestamps null: false
    end
  end
end
