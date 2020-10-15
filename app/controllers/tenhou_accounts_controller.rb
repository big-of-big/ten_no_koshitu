class TenhouAccountsController < ApplicationController
  before_action :set_team, only: %i[show edit update destory]
  def index
  end

  def show
  end

  private
    def set_team
      @user = Team.find(params[:id])
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
