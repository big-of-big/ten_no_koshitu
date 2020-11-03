class UsersController < ApplicationController
  include LogsHelper
  before_action :authenticate_user!
  # before_action :ensure_correct_user, only: %i[edit update destroy]
  before_action :set_user, only: %i[show edit update destory]

  def index
  end

  def show
    team_logs = TeamLog.where(team_id: @user.team.id)
    # 2次元配列
    ary_of_games =
      team_logs.map do |team_log|
        JSON.parse(team_log.content)
      end
    # ユーザーの打った試合のログ
    @logs =
      ary_of_games.flatten!.select do |game|
        tenhou_accounts_names = extract_tenhou_accounts_from(game)
        tenhou_accounts_names.include?(@user.tenhou_account)
        # game => "L1412 | 20:50 | 四般東喰赤－ | フレアドライブ(+50.0) コロナビーム！！(+2.0) モラルハザード(-21.0) crepe(-31.0)"
      end
    @hash = score_hash(@logs,@user.tenhou_account)

    @total_scores =
      @logs.map do |my_game|
        m = /#{Regexp.escape(@user.tenhou_account)}\((?<score>.+?)\)/.match(my_game)
        m[:score].to_i
      end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email)
    end

    def ensure_correct_user
      if @book.user_id != current_user.id
        redirect_to root_path, notice: t(".flash_no_authority")
      end
    end
end
