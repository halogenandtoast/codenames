class GamesController < ApplicationController
  before_action :redirect_to_game, only: [:new]
  def new
    @game = Game.new
    @player = Player.new
  end

  def create
    @game = GameCreator.new.create
    player = @game.players.create(player_params)
    session[:player_id] = player.id

    redirect_to @game
  end

  def show
    @game = Game.find(params[:id])
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    redirect_to root_path
  end

  private

  def player_params
    params.
      require(:game).
      require(:player).
      permit(:name).
      merge(ip_address: request.remote_ip)
  end

  def redirect_to_game
    if current_game
      redirect_to current_game
    end
  end
end
