class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: %i[edit update]
  before_action :ensure_correct_team, only: %i[edit update]

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new(team_params)
    current_user.team = @team
    @team.join_key = @team.object_id

    ActiveRecord::Base.transaction do
      @team.save!
      current_user.save!
    end
    redirect_to root_path, notice: "チームを作成しました。"

    rescue
      render :new
  end

  def update
    if @team.update(team_params)
      redirect_to root_path, notice: "チーム情報を更新しました。"
    else
      render :edit
    end
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name)
    end

    def ensure_correct_team
      if current_user.team != @team
        redirect_to root_path, notice: "権限がありません。"
      end
    end
end
