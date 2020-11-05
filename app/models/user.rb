class User < ApplicationRecord
  include TenhouAccountsHelper
  belongs_to :team, optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, presence: true

  # deviseのメソッドをオーバーライドして、パスワード無しでユーザー情報を編集できるようにする
  def update_with_password(params)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    result = update(params)
    clean_up_passwords
    result
  end
end
