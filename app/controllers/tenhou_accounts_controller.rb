class TenhouAccountsController < ApplicationController
  include LogsHelper
  before_action :set_tenhou_account, only: %i[show edit update destroy]
  before_action :authenciate_team_member, only: %i[show edit update destroy]

  # def index
  #   @tenhou_accounts = TenhouAccount.all
  # end

  def show
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

    @my_one_game_objects =
      one_game_objects.select do |one_game_object|
        tenhou_accounts_names = extract_tenhou_accounts_from(one_game_object.one_game_log)
        tenhou_accounts_names.include?(@tenhou_account.name)
      end

    @three_games = []
    @four_games = []
      @my_one_game_objects.each do |my_one_game_object|
        if my_one_game_object.type == 3
          @three_games << my_one_game_object
        else
          @four_games << my_one_game_object
        end
      end

    @four_games_scores =
      @four_games.map do |four_game|
        m = /#{Regexp.escape(@tenhou_account.name)}\((?<score>.+?)\)/.match(four_game.one_game_log)
        m[:score].to_i
      end

    @three_games_scores =
      @three_games.map do |three_game|
        m = /#{Regexp.escape(@tenhou_account.name)}\((?<score>.+?)\)/.match(three_game.one_game_log)
        m[:score].to_i
      end

    @four_games_rankings =
      @four_games.map do |four_game|
        tenhou_accounts_names = extract_tenhou_accounts_from(four_game.one_game_log)
        tenhou_accounts_names.index(@tenhou_account.name) + 1
      end

    @three_games_rankings =
      @three_games.map do |three_game|
        tenhou_accounts_names = extract_tenhou_accounts_from(three_game.one_game_log)
        tenhou_accounts_names.index(@tenhou_account.name) + 1
      end
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
