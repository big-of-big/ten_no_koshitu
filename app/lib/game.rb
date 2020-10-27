class Game
  attr_accessor :name, :content
  def initialize(name,content)
    @name = name
    @content = content # 全てのログ（文字列）
  end
end

class OneGame
  include LogsHelper
  attr_accessor :name, :one_game_log, :type, :date
  def initialize(name, one_game_log)
    @name = name
    @one_game_log = one_game_log
    @type = set_type(one_game_log)
    @date = name.to_date
  end

  def four_or_three(one_game_log)
    logs = { name: game.name, content: JSON.parse(game.content) }
  end

  def set_type(one_game_log)
    ary = one_game_log.split(" ")

    if ary.count == 10 ## 4人打ち
      4
    else ## 3人打ち
      3
    end
  end

  def year_month
    self.date.strftime("%Y/%m")
  end
end

class OneMonthGames
  attr_accessor :name,:games, :four_games, :three_games
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
