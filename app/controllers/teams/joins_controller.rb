class Teams::JoinsController < ApplicationController
  def index
  end
  def new
  end
  def create
  end
  def destroy
    current_user.team = nil
    current_user.save!
    redirect_to root_path, notice: "チームから脱退しました"
  end
end
