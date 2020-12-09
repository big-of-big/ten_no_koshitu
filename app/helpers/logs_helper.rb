module LogsHelper
  # viewから使っている
  def scores(games, tenhou_account_name)
    games.map do |game|
      m = /#{Regexp.escape(tenhou_account_name)}\((?<score>.+?)\)/.match(game.one_game_log)
      m[:score].to_i
    end
  end

  # viewから使っている
  def rankings(games, tenhou_account_name)
    log = Log.new
    games.map do |game|
      tenhou_accounts_names = log.extract_tenhou_accounts_from(game.one_game_log)
      tenhou_accounts_names.index(tenhou_account_name) + 1
    end
  end
end
