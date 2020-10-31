class TenhouAccountsController < ApplicationController
  include LogsHelper
  before_action :set_tenhou_account, only: %i[show edit update destroy]
  before_action :authenciate_team_member, only: %i[show edit update destroy]

  # def index
  #   @tenhou_accounts = TenhouAccount.all
  # end

  def show
    # 全期間のTeamLogオブジェクトを取得している
    team_logs = TeamLog.where(team_id: @tenhou_account.team_id)
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
        tenhou_accounts_names.include?(@tenhou_account.name)
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

    # # @three_games_hash = { 2020/02:[game,game], 2020/03: [game,game,game]] }
    # # 月別のgameオブジェクトが入ったハッシュ
    # @three_games_hash = { }
    # @three_games.each do |game|
    #   unless @three_games_hash.has_key?(game.year_month)
    #     @three_games_hash[game.year_month] = []
    #   end
    #   @three_games_hash[game.year_month] << game
    # end
    #
    # @four_games_hash = { }
    # @four_games.each do |game|
    #   unless @four_games_hash.has_key?(game.year_month)
    #     @four_games_hash[game.year_month] = []
    #   end
    #   @four_games_hash[game.year_month] << game
    # end


    # 3人打ち4人打ち合算の月別gameオブジェクトが入ったハッシュ
    all_games_hash = {}
    @my_one_game_objects.each do |game|
      unless all_games_hash.has_key?(game.year_month)
        all_games_hash[game.year_month] = []
      end
      all_games_hash[game.year_month] << game
    end

    @one_month_games =
      all_games_hash.map do |name, games|
        OneMonthGames.new(name,games)
      end

    # 4人打ちの全期間の得点が入った配列
    @four_games_scores = scores(@four_games, @tenhou_account.name)

    # 3人打ちの全期間の得点が入った配列
    @three_games_scores = scores(@three_games, @tenhou_account.name)

    # 4人打ちの全期間の順位が入った配列
    @four_games_rankings = rankings(@four_games, @tenhou_account.name)

    # 3人打ちの全期間の順位が入った配列
    @three_games_rankings = rankings(@three_games, @tenhou_account.name)
  end

  def new
    @tenhou_account = TenhouAccount.new
  end

  def edit
  end

  def create
    tenhou_account = TenhouAccount.new(tenhou_account_params)
    tenhou_account.team = current_user.team

    if tenhou_account.save
      redirect_to root_path, notice: "チームにメンバーを追加しました"
    else
      render :new
    end
  end

  def update
    if @tenhou_account.update(tenhou_account_params)
      redirect_to edit_team_path(@tenhou_account.team), notice: "天鳳アカウントを変更しました"
    else
      render :edit
    end
  end

  def destroy
    @tenhou_account.destroy
    redirect_to root_path, notice: "メンバーを削除しました。"
  end

  private
    def set_tenhou_account
      @tenhou_account = TenhouAccount.find(params[:id])
    end

    def tenhou_account_params
      params.require(:tenhou_account).permit(:name)
    end

    def authenciate_team_member
      if @tenhou_account.team != current_user.team
        redirect_to root_path, notice: "権限がありません"
      end
    end
end
