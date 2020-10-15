class TenhouAccountsController < ApplicationController
  before_action :set_tenhou_account, only: %i[show edit update destroy]
  def index
    @tenhou_accounts = TenhouAccount.all
  end

  def show
  end

  def new
    @tenhou_account = TenhouAccount.new
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

    def ensure_correct_user
      if @book.user_id != current_user.id
        redirect_to root_path, notice: t(".flash_no_authority")
      end
    end
end
