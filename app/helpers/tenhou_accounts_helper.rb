module TenhouAccountsHelper
  include LogsHelper

  # viewから使っている
  def set_three_and_four_games(tenhou_account)
    my_one_game_objects = set_my_one_game_objects(tenhou_account)
    # この配列に全期間の3人打ちと4人打ちのgame_objectが格納されている
    three_games = []
    four_games = []
    my_one_game_objects.each do |my_one_game_object|
      if my_one_game_object.type == 3
        three_games << my_one_game_object
      else
        four_games << my_one_game_object
      end
    end
    { three_games: three_games, four_games: four_games }
  end

  def set_my_one_game_objects(tenhou_account)
    one_game_objects = set_one_game_objects(tenhou_account)

    # 全期間の4人打ちと3人打ちが混じった配列
    my_one_game_objects =
      one_game_objects.select do |one_game_object|
        tenhou_accounts_names = extract_tenhou_accounts_from(one_game_object.one_game_log)
        tenhou_accounts_names.include?(tenhou_account.name)
      end
    my_one_game_objects
  end

  def set_one_game_objects(tenhou_account)
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

  def make_one_month_games_objects(one_game_objects)
    all_games_hash = {}
    one_game_objects.each do |game|
      unless all_games_hash.has_key?(game.year_month)
        all_games_hash[game.year_month] = []
      end
      all_games_hash[game.year_month] << game
    end

    one_month_games(all_games_hash)
  end

  def one_month_games(games_hash)
    games_hash.map do |name, games|
      OneMonthGames.new(name, games)
    end
  end
end
