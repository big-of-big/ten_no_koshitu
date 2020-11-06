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

    if @team.save && current_user.save
      redirect_to root_path, notice: "チームを作成しました"
    else
      render :new
    end
  end

  def update
    if @team.update(team_params)
      redirect_to root_path, notice: "チーム情報を更新しました"
    else
      render :edit
    end
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name, :image)
    end

    def ensure_correct_team
      if current_user.team != @team
        redirect_to root_path, notice: "権限がありません。"
      end
    end
end
