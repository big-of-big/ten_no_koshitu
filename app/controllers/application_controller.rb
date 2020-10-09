class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      attrs = [:name, :tenhou_account, :image]
      devise_parameter_sanitizer.permit(:sign_up, keys: attrs)
      devise_parameter_sanitizer.permit(:account_update, keys: attrs)
    end
end
