require 'levenshtein'
namespace :matches do
  desc 'calculates matches data'
  task data: :environment do
    teams = Team.all.pluck(:name)
    Result.all.order(date: :asc).each do |result|
      season_phase = SeasonTime.new.season_phase(result)
       attrs = {
         date: result.date,
         result: result.result,
         home_score: result.home_score,
         away_score: result.away_score,
         season: result.season,
         season_time: season_phase,
         home_team: result.home_team,
         away_team: result.away_team
       }
       if MatchDatum.where(attrs).any?
         puts "#{result.season}\t\t#{result.home_team} VS #{result.away_team}".green
         next
       end
       ms = MatchStats.new(result.home_team, result.away_team, date: result.date)

       t = find_team_rank(teams, result.home_team).try(:rank_points).to_f
       t2 = find_team_rank(teams, result.away_team).try(:rank_points).to_f
       attrs.merge!(ms.data)
       attrs[:home_rank] = t
       attrs[:away_rank] = t2
       data = MatchDatum.create(attrs)
       if data.id
         puts "#{result.season}\t\t#{result.home_team} VS #{result.away_team}".green
       else
         data.errors.full_messages.join(',').yellow
       end
    end
  end

  def find_team_rank(teams, team_name)
    teams.find { |t| Levenshtein.distance(t, team_name) < 5 }
  end

end
