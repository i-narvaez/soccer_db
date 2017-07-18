class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :zone
      t.string :country
      t.string :league
      t.integer :rank
      t.integer :rank_points
      t.timestamps
    end
  end
end
