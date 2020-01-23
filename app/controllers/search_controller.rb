class SearchController < ApplicationController
  def search
    @players = Player.search(params[:query])
    @high_school_teams = HighSchoolTeam.search(params[:query])
    @club_teams = ClubTeam.search(params[:query])
    @fields = Field.search(params[:query])
    @tournaments = Tournament.search(params[:query])

    respond_to do |r|
      r.json {}
      r.html {}
    end
  end
end
