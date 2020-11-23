class Teams::LogsController < ApplicationController
  def index
    @logs = TeamLog.where(team_id: current_user.team.id)
                  .order(created_at: "DESC")
                  .page(params[:page])
                  .per(10)
    @team_logs = @logs.map do |log|
        { name: log.name, content: JSON.parse(log.content) }
      end
  end
end
