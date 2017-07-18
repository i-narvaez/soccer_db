class MatchStreak
  def streak(home, away, streak, date)
    @date = date
    matches = load_matches(home, away).limit(streak)
    calculate_match_streak(matches, home)
  end

  private

  def calculate_match_streak(matches, home)
    return 0 if matches.size == 0
    score = matches.map do |r|
      p = r.points(home)
      p
    end.reduce(:+)
    (score.to_f / (matches.size * 3)).round(2)
  end

  def judge(result)
    return 1 if result.w?
    return 0 if result.d?
    return -1 if result.l?
  end

  def load_matches(home, away)
    m = Result.order(date: :desc).where(
      '(home_team = ? and away_team = ?) or (home_team = ? and away_team = ?)',
      home, away,
      away, home
    )
    return m unless @date
    m.where('date < ?', @date)
  end
end
