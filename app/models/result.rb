class Result < ApplicationRecord
  enum result: [:w, :d, :l]
 
  def points(team)
    home_team == team ? points_for_home : points_for_visit
  end

  def points_for_home
    return 3 if w?
    return 1 if d?
    0
  end

  def points_for_visit
    return 0 if w?
    return 1 if d?
    3
  end

  def scored(team)
    home_team == team ? home_score : away_score
  end
 
  def received(team)
    home_team != team ? home_score : away_score
  end

  class << self
    def statistics(team, season)
      scope = matches_for(team).where(season: season)
      {
        points: points(scope, team),
        home: home_avg(scope, team),
        away: away_avg(scope, team),
        avg_score: avg_score(scope, team),
        avg_received: avg_received(scope, team)
      }
    end

    def avg_received(scope, team)
      goals = scope.map { |r| r.received(team) }.reduce(:+)
      (goals.to_f / scope.count).round 2
    end

    def avg_score(scope, team)
      total_matches = scope.count
      return 0 if total_matches == 0
      goals = scope.map { |r| r.scored(team).to_i }.reduce(:+)
      (goals.to_f / total_matches).round 2
    end

    def home_avg(scope, team)
      total = scope.where(home_team: team).count * 3
      return 0 if total == 0
      win = scope.where(home_team: team).map(&:points_for_home).reduce(:+)
      win.to_f * 100 / total
    end

    def away_avg(scope, team)
      total = scope.where(away_team: team).count * 3
      return 0 if total == 0
      win = scope.where(away_team: team).map(&:points_for_visit).reduce(:+)
      win * 100 / total
    end

    def points(scope, team)
      scope.sum { |r| r.points(team) }.to_i
    end

    def home_for(team)
      where(home_team: team)
    end

    def away_for(team)
      where(away_team: team)
    end

    def matches_for(team)
      where("home_team = ? or away_team = ?", team, team)
    end
  end
end
