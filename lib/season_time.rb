class SeasonTime
  def initialize
  end

  def season_phase(result)
    matches = matches_in_season(result)
    i = matches.find_index(result.date) + 1
    quarter = matches.size / 4
    return 'start' if i <= quarter
    return 'end' if i > (quarter * 3)
    'mid'
  end

  private

  def matches_in_season(result)
    Result.matches_for(result.home_team).where(season: result.season)
      .pluck(:date)
  end

end
