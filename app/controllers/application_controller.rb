class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  helper_method :current_player
  def current_player
    Player.find_by(id: session[:player_id]) || NullPlayer.new
  end

  def current_game
    current_player.game
  end
end
