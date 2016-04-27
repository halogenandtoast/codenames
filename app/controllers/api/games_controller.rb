class Api::GamesController < ApplicationController
  def show
    game = Game.find(params[:id])
    render json: game
  end
end
