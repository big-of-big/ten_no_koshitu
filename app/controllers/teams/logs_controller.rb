class Teams::LogsController < ApplicationController
  def index
    logs = TeamLog.where(team_id: params[:id])
    @team_logs = logs.map do |log|
      JSON.parse(log.content)
      end
    @team_logs.flatten!
  end
end
