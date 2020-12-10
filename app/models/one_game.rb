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

  def self.my_one_game_objects_of(tenhou_account)
    log = Log.new
    one_game_objects = one_game_objects_of(tenhou_account)

    # 全期間の4人打ちと3人打ちが混じった配列
    my_one_game_objects =
      one_game_objects.select do |one_game_object|
        tenhou_accounts_names = log.extract_tenhou_accounts_from(one_game_object.one_game_log)
        tenhou_accounts_names.include?(tenhou_account.name)
      end
    my_one_game_objects
  end

  def self.one_game_objects_of(tenhou_account)
    team_logs = TeamLog.where(team_id: tenhou_account.team_id)
    game_objects =
      team_logs.map do |team_log|
        Game.new(team_log.name, team_log.content)
      end

    one_game_objects = []

    game_objects.each do |game_object|
      JSON.parse(game_object.content).each do |one_game_log|
        one_game_objects << OneGame.new(game_object.name, one_game_log)
      end
    end
    one_game_objects
  end
end
