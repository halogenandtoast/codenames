class ReplaysController < ApplicationController
  def create
    @game = GameCreator.new.create

    new_spymaster = rand(current_red_players.count)
    current_red_players.each_with_index do |player, index|
      player.update(game: @game, spymaster: index == new_spymaster)
    end

    new_spymaster = rand(current_blue_players.count)
    current_red_players.each_with_index do |player, index|
      player.update(game: @game, spymaster: index == new_spymaster)
    end

    @game.update(started: true)
    redirect_to @game
  end

  private

  def current_red_players
    @current_red_players ||= current_game.players_on_team("red")
  end

  def current_blue_players
    @current_blue_players ||= current_game.players_on_team("blue")
  end
end
