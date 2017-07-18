class CreateCreateResults < ActiveRecord::Migration[5.1]
  def change
    create_table :results do |t|
      t.datetime :date
      t.string :season
      t.string :league
      t.string :home_team
      t.string :away_team
      t.integer :home_score
      t.integer :away_score
      t.integer :difference
      t.integer :result
      t.timestamps
    end
  end
end
