class GameSessionsController < ApplicationController
  def create
    players = game.players.shuffle
    half = random_half(players.count)
    red_team = players.take(half)
    blue_team = players.drop(half)
    red_team.each_with_index.map do |player, i|
      player.update(color: "red", spymaster: i == 0)
    end
    blue_team.each_with_index.map do |player, i|
      player.update(color: "blue", spymaster: i == 0)
    end
    game.update(started: true)
    redirect_to game
  end

  private

  def game
    @game ||= Game.find(params[:game_id])
  end

  def random_half(count)
    half = count / 2.0
    rand(2) == 1 ? half.floor : half.ceil
  end
end
