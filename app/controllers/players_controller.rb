class PlayersController < ApplicationController
  before_action :authorize_user, except: [:index, :show]
  helper_method :filter_params

  def index
    @filter_options = Player.filter_options
    @filters_to_apply = players_table_filter_params && !players_table_filter_params.empty?
    @players = Player.sorted_players(players_table_sort_column, sort_direction)
    @players = @filters_to_apply ? get_filtered_players(@players, players_table_filter_params) : @players
  end

  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
    @player.address = Address.new
  end

  def edit
    @player = Player.find(params[:id])
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to @player
    else
      render 'new'
    end
  end

  def update
    @player = Player.find(params[:id])

    if @player.update(player_params)
      redirect_to @player
    else
      render 'edit'
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    redirect_to players_path
  end

  private
    def player_params
      params_for_player = params
        .require(:player)
        .permit(:first_name, :middle_name, :last_name, :feet_component_of_height, :inches_component_of_height, :weight, :birthday, :high_school_team_id, :club_team_id, :gpa, :class_year, :intended_major, :email, :phone_number, :notes, address_attributes: [ :id, :line_one, :line_two, :city, :state, :zip ])

      if params_for_player[:feet_component_of_height].empty? || params_for_player[:inches_component_of_height].empty?
        params_for_player[:height] = nil
      else
        params_for_player[:height] = (params_for_player[:feet_component_of_height].to_i * 12) + params_for_player[:inches_component_of_height].to_i
      end

      return params_for_player.except(:feet_component_of_height, :inches_component_of_height)
    end

    def filter_params
      players_table_filter_params
    end
end
