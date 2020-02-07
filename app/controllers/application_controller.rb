class ApplicationController < ActionController::Base
  helper_method :is_admin?, :players_table_sort_column, :sort_direction, :players_table_filter_params
  before_action :require_read_access

  def require_read_access
    unless has_read_access?
      flash[:alert] = "You must have read access in order to view this page."
      redirect_to root_path
    end
  end

  def is_admin?
    user_signed_in? && current_user.admin?
  end

  def has_read_access?
    user_signed_in? && current_user.read_access?
  end

  def authorize_user
    if !is_admin?
      redirect_to root_path, alert: "You are not authorized to perform that action."
    end
  end

  def players_table_sort_column
    %w[first_name height weight high_school_team club_team class_year gpa].include?(params[:sort]) ? params[:sort] : "first_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def players_table_filter_params
    params.permit(:sort, :direction, :shortest_feet, :shortest_inches, :tallest_feet, :tallest_inches, :lightest, :heaviest, :smallest_gpa, :largest_gpa, :commit, :id, high_school_team_filters: [], club_team_filters: [], class_year_filters: []).except(:id, :commit, :sort, :direction)
  end

  def get_filtered_players(players, filters)
    return players.filter do |player|
      player.passes_through_filters(filters)
    end
  end
end
