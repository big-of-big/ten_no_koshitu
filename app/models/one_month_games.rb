class OneMonthGames
  attr_accessor :name, :four_games, :three_games
  def initialize(name, games)
    @name = name
    @three_games = []
    @four_games = []
    divide_three_and_four_of(games)
  end

  def divide_three_and_four_of(games)
    games.each do |my_one_game_object|
      if my_one_game_object.type == 3
        @three_games << my_one_game_object
      else
        @four_games << my_one_game_object
      end
    end
  end

  def self.make_one_month_games_objects(one_game_objects)
    all_games_hash = {}
    one_game_objects.each do |game|
      unless all_games_hash.has_key?(game.year_month)
        all_games_hash[game.year_month] = []
      end
      all_games_hash[game.year_month] << game
    end

    one_month_games(all_games_hash)
  end

  def self.one_month_games(games_hash)
    games_hash.map do |name, games|
      OneMonthGames.new(name, games)
    end
  end
end
