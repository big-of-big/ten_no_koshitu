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
  def initialize(name,games)
    @name = name
    @game = games
  end
end
