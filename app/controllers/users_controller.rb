class UsersController < ApplicationController
  include LogsHelper
  before_action :authenticate_user!
  # before_action :ensure_correct_user, only: %i[edit update destroy]
  before_action :set_user, only: %i[show edit update destory]

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
