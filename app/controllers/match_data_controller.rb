class MatchDataController < ApplicationController
  def index
    load_matches
    filter
    filter_match
    load_options
  end

  private

  def load_matches
    @matches = MatchDatum.order(date: :desc).paginate(
      page: params[:page], per_page: 50)
  end

  def filter
    team = params[:team]
    return unless team.present?
    @matches = @matches.where('home_team = ? or away_team = ?', team, team)
  end
 
  def filter_match
    team1 = params[:home]
    team2 = params[:away]
    return if team1.blank? && team2.blank?
    return @matches = @matches.where(home_team: team1) unless team2.present?
    @matches = @matches.where('(home_team = ? and away_team = ?) or
                              (home_team = ? and away_team = ?)',
                               team1, team2, team2, team1)
  end

  def load_options
    @options = Result.distinct(:home_team).pluck(:home_team)
  end
end
