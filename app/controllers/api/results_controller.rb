class Api::ResultsController < Api::BaseController
# ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def create
    # start_date = params[:start_date]
    # end_date = params[:end_date]
    # @tenhou_account = TenhouAccount.find(params[:id])
    # # 全期間のTeamLogオブジェクトを取得している
    # team_logs = TeamLog.where(team_id: @tenhou_account.team_id)
    # game_objects =
    #   team_logs.map do |team_log|
    #     Game.new(team_log.name, team_log.content)
    #   end
    #
    # one_game_objects = []
    #
    # game_objects.each do |game_object|
    #   JSON.parse(game_object.content).each do |one_game_log|
    #    one_game_objects << OneGame.new(game_object.name,one_game_log)
    #   end
    # end
    #
    # # 全期間の4人打ちと3人打ちが混じった配列
    # @my_one_game_objects =
    #   one_game_objects.select do |one_game_object|
    #     tenhou_accounts_names = extract_tenhou_accounts_from(one_game_object.one_game_log)
    #     tenhou_accounts_names.include?(@tenhou_account.name)
    #   end
    #
    # @one_month_games =
    #   all_games_hash.map do |name, games|
    #     OneMonthGames.new(name,games)
    #   end

      render json: {name:"lamp",age:34}
      # render template: "tenhou_accounts/index"
    # render json: @one_month_games
  end
end
