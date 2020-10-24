class TenhouAccountsController < ApplicationController
  before_action :set_tenhou_account, only: %i[show edit update destroy]
  before_action :authenciate_team_member, only: %i[show edit update destroy]

  def index
    @tenhou_accounts = TenhouAccount.all
  end

  def show
    team_logs = TeamLog.where(team_id: @tenhou_account.team_id)
    ary =
      team_logs.map do |team_log|
        JSON.parse(team_log.content)
      end
    # ユーザーの打った試合のログ
    @logs =
      ary.flatten!.select do |game|
        tenhou_accounts_names = extract_tenhou_accounts_from(game)
        tenhou_accounts_names.include?(@tenhou_account.name)
        # game => "L1412 | 20:50 | 四般東喰赤－ | フレアドライブ(+50.0) コロナビーム！！(+2.0) モラルハザード(-21.0) crepe(-31.0)"
      end

    @total_scores =
      @logs.map do |my_game|
        m = /#{Regexp.escape(@tenhou_account.name)}\((?<score>.+?)\)/.match(my_game)
        m[:score].to_i
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
end
