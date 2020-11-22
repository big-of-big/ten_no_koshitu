class Teams::LogsController < ApplicationController
  def index
    logs = TeamLog.where(team_id: params[:id]).order(created_at: "DESC")
    @team_logs = logs.map do |log|
        { name: log.name, content: JSON.parse(log.content) }
      end
  end
end
