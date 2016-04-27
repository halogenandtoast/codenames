class PlayersController < ApplicationController
  def create
    if game
      player = game.players.create(player_params)
      session[:player_id] = player.id
      redirect_to game
    else
      redirect_to root_path, alert: "No game found"
    end
  end

  private

  def game
    @game ||= Game.find_by(code: params[:player][:game][:code])
  end

  def player_params
    params.require(:player).permit(:name).merge(ip_address: request.remote_ip)
  end
end
