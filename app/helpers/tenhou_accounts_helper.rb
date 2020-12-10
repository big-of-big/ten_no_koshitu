module TenhouAccountsHelper
  def three_and_four_games_of(tenhou_account)
    my_one_game_objects = OneGame.my_one_game_objects_of(tenhou_account)
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
end
