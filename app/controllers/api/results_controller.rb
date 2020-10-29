class Api::ResultsController < Api::BaseController
# ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  # def index
  #   render json: {name: "hoge"}
  # end
end
