class CreateMatchData < ActiveRecord::Migration[5.1]
  def change
    create_table :match_data do |t|
      t.datetime :date
      t.integer :result
      t.integer :home_score
      t.integer :away_score
      t.string :home_team
      t.string :away_team
      t.string :season
      t.string :season_time
      t.float :match_streak
      t.float :home_effectiveness
      t.float :away_effectiveness
      t.float :home_avg_goals
      t.float :away_avg_goals
      t.float :home_general_streak
      t.float :away_general_streak
      t.float :home_rank
      t.float :away_rank
      t.timestamps
    end
  end
end
