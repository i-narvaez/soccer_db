class MatchStats
  attr_accessor :home, :away, :options
  def initialize(home, away, options = {})
    self.home = home
    self.away = away
    self.options = {}.merge(options)
    default_options
  end

  def data
    averages.merge(streaks).merge(match_streak)
  end

  def match_streak
    mr = MatchStreak.new
    { match_streak: mr.streak(home, away, options[:streak], date) }
  end

  def default_options
    options[:streak] = 6
  end

  def date
    options[:date]
  end

  def averages
    {
      home_effectiveness: Result.home_avg(home_scope, home),
      home_avg_goals: Result.avg_score(team_scope(home), home),
      away_effectiveness: Result.away_avg(away_scope, away),
      away_avg_goals: Result.avg_score(team_scope(away), away)
    }
  end

  def streaks
    s = Streaks.new(date)
    {
      home_general_streak: s.streak(home, options[:streak]),
      away_general_streak: s.streak(away, options[:streak])
    }
  end

  def home_scope
    m = Result.home_for(home).order(date: :desc).limit(options[:streak])
    return m unless date.present?
    m.where('date < ?', date)
  end

  def away_scope
    m = Result.away_for(away).order(date: :desc).limit(options[:streak])
    return m unless date.present?
    m.where('date < ?', date)
  end

  def team_scope(team)
    m = Result.matches_for(team).order(date: :desc).limit(options[:streak])
    return m unless date.present?
    m.where('date < ?', date)
  end
end
