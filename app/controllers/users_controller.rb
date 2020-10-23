class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :ensure_correct_user, only: %i[edit update destroy]
  before_action :set_user, only: %i[show edit update destory]

  def index
    if current_user.team.present?
      @tenhou_accounts = current_user.team.tenhou_accounts
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :tenhou_account, :email, :picture)
    end

    def ensure_correct_user
      if @book.user_id != current_user.id
        redirect_to root_path, notice: t(".flash_no_authority")
      end
    end
end
