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
end
