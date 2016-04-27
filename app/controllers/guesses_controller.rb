class GuessesController < ApplicationController
  def create
    current_game.update(game_params)
    redirect_to current_game
  end

  private

  def game_params
    {
      data: updated_data
    }
  end

  def updated_data
    mutable_data = current_game.data.dup
    index = current_game.data["words"].index(word)
    mutable_data["words"][index]["guessed"] = true
    mutable_data
  end

  def word
    @word ||= current_game.data["words"].find { |word| word["text"] == params[:word] }
  end
end
