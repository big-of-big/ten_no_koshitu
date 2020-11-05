module TenhouAccountsHelper
  include LogsHelper

  def set_three_and_four_games(tenhou_account)
    team_logs = TeamLog.where(team_id: tenhou_account.team_id)
    game_objects =
      team_logs.map do |team_log|
        Game.new(team_log.name, team_log.content)
      end

    one_game_objects = []

    game_objects.each do |game_object|
      JSON.parse(game_object.content).each do |one_game_log|
       one_game_objects << OneGame.new(game_object.name,one_game_log)
      end
    end

    # 全期間の4人打ちと3人打ちが混じった配列
    @my_one_game_objects =
      one_game_objects.select do |one_game_object|
        tenhou_accounts_names = extract_tenhou_accounts_from(one_game_object.one_game_log)
        tenhou_accounts_names.include?(tenhou_account.name)
      end

    # この配列に全期間の3人打ちと4人打ちのgame_objectが格納されている
    # この配列は必要。この配列から月別にまとめられる？
    @three_games = []
    @four_games = []
      @my_one_game_objects.each do |my_one_game_object|
        if my_one_game_object.type == 3
          @three_games << my_one_game_object
        else
          @four_games << my_one_game_object
        end
      end
      { three_games: @three_games, four_games: @four_games }
  end
end
