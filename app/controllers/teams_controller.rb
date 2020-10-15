class TeamsController < ApplicationController
  before_action :set_team, only: %i[show edit update destory]

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    team = Team.new(team_params)
    team.join_key = team.object_id

    if team.save
      redirect_to root_path, notice: "チームを作成しました"
    else
      render :new
    end
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name, :image)
    end

    def ensure_correct_user
      if @book.user_id != current_user.id
        redirect_to root_path, notice: t(".flash_no_authority")
      end
    end
end
