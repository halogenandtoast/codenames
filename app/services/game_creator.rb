class GameCreator
  COLORS = %w(red blue)

  def initialize
    @game = Game.new(first: COLORS.sample)
  end

  def create
    game.code = generate_code
    game.data = game_data
    game.save
    game
  end

  private

  attr_reader :game

  def game_data
    words = choose_words

    {
      words: words
    }
  end

  def generate_code
    code = SecureRandom.hex(3)

    while Game.where(code: code).exists?
      code = SecureRandom.hex(3)
    end

    code
  end

  def choose_words
    list = File.read(Rails.root.join("lib", "data", "words"))
    all_words = list.lines.map(&:strip)
    game_words = all_words.shuffle.take(25)
    assign_spies(game_words).shuffle
  end

  def assign_spies(words)
    red_words(words) + blue_words(words) + [assasin_word(words)] + neutral_words(words)
  end

  def count_for(color)
    game.first == color ? 9 : 8
  end

  def red_words(words)
    words.take(count_for("red")).map { |word| { text: word, type: "red", guessed: false } }
  end

  def blue_words(words)
    words.drop(count_for("red")).take(count_for("blue")).map do |word|
      { text: word, type: "blue", guessed: false }
    end
  end

  def assasin_word(words)
    { text: words[17], type: "assassin", guessed: false }
  end

  def neutral_words(words)
    words.drop(18).map { |word| { text: word, type: "neutral", guessed: false } }
  end
end
