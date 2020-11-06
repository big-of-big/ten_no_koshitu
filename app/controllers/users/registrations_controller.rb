class Users::RegistrationsController < Devise::RegistrationsController
  protected
    def update_resource(resource, params)
      return super if params["password"]&.present?
      # 現在のパスワードなしでアカウントの更新をする
      resource.update_without_password(params.except("current_password"))
    end
end
