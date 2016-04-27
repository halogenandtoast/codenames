class Api::GamesController < ApplicationController
  def show
    game = Game.find_by(id:params[:id])
    if game
      render json: game
    else
      render json: { deleted: true }
    end
  end
end
