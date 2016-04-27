class Game < ActiveRecord::Base
  has_many :players, dependent: :destroy

  def game_over?
    red_words.all? { |w| w["guessed"] } ||
      blue_words.all? { |w| w["guessed"] } ||
      assassin_word["guessed"]
  end

  private

  def red_words
    @red_words ||= words_of_type("red")
  end

  def blue_words
    @blue_words ||= words_of_type("blue")
  end

  def assassin_word
    @assassin_word ||= words_of_type("assassin").first
  end

  def words_of_type(type)
    data["words"].select { |w| w["type"] == type }
  end
end
