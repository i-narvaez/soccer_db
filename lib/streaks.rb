class Streaks

  def initialize(date)
    @date = date
  end

  def home_streak(team, games)
    streak(team, games, :home)
  end

  def away_streak(team, games)
    streak(team, games, :away)
  end

  def streak(team, games, condition = :all)
    matches = load_matches(team, condition)
    return unless matches
    calculate_streak_points(matches.limit(games), team)
  end

  private

  def calculate_streak_points(matches, team)
    t = matches.size
    return 0 if t == 0
    p = Result.points(matches, team)
    (p.to_f / (t * 3)).round 2
  end

  def load_matches(team, condition = :all)
    m = matches_for(team)
    return m if condition == :all
    return m.where(home_team: team) if condition == :home
    return m.where(away_team: team) if condition == :away
  end

  def matches_for(team)
    m = Result.where("home_team = ? or away_team = ?", team, team)
      .order(date: :desc)
    return m unless @date.present?
    m.where('date < ?', @date)
  end
end
