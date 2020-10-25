module LogsHelper

  def extract_tenhou_accounts_from(game)
    ary = game.split(" ")
    ary.shift(6) # ログから不要な部分を削除
    names =
      ary.map do |game|
        # 天鳳アカウント名に()を含むことはできない
        m = /(?<name>.+)\(/.match(game)
        m[:name]
      end
    names
  end

  def distinguish_four_game_from_three_game(games)
    hash = { four_games: [], three_games: [] }
    games.each do |game|
      ary = game.split(" ")

      if ary.count == 10 ## 4人打ち
        hash[:four_games] << game
      else ## 3人打ち
        hash[:three_games] << game
      end
    end
    hash
  end

  # 自分の4人打ち・3人打ちの得点を配列で持つハッシュを作る
  def score_hash
    game_hash = distinguish_four_game_from_three_game(my_games)
    four_game_scores =
      game_hash[:four_games].map do |game|
        m = /#{tenhou_account}\((?<score>.+?)\)/.match(my_game)
        m[:score].to_i
      end
    three_game_scores =
      game_hash[:three_games].map do |game|
        m = /#{tenhou_account}\((?<score>.+?)\)/.match(my_game)
        m[:score].to_i
      end
    {four_game_scores: four_game_scores, three_game_scores: three_game_scores}
  end

end
