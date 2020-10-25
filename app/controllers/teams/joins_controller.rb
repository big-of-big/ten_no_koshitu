class Teams::JoinsController < ApplicationController
  def new
  end
  def create
    join_key = params[:team_id].to_s
    team = Team.find_by(join_key: join_key)
    binding.pry
    if team.present?
      current_user.team = team
      current_user.save!
      redirect_to root_path, notice: "チームに参加しました"
    else
      flash.now[:alert] =  "チームが見つかりませんでした"
      flash.now[:join_key] = join_key
      render :new
    end
  end
  def destroy
    current_user.team = nil
    current_user.save!
    redirect_to root_path, notice: "チームから脱退しました"
  end
end
