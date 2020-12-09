class OneGame
  include LogsHelper
  attr_accessor :name, :one_game_log, :type, :date
  def initialize(name, one_game_log)
    @name = name
    @one_game_log = one_game_log
    @type = game_type_of(one_game_log)
    @date = name.to_date
  end

  def game_type_of(one_game_log)
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
