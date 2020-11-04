module LogsHelper

  # チームメンバー全員の名前の配列を作る
  def team_members(team)
    return if team.tenhou_accounts.empty?
    tenhou_names = team.tenhou_accounts.map do |tenhou_account|
      tenhou_account.name
    end
    tenhou_names
  end

  # 1つのログから天鳳アカウント名だけ抜き出し配列にする
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

  def scores(games,tenhou_account_name)
    games.map do |game|
      m = /#{Regexp.escape(tenhou_account_name)}\((?<score>.+?)\)/.match(game.one_game_log)
      m[:score].to_i
    end
  end

  def rankings(games, tenhou_account_name)
    games.map do |game|
      tenhou_accounts_names = extract_tenhou_accounts_from(game.one_game_log)
      tenhou_accounts_names.index(tenhou_account_name) + 1
    end
  end
end
