class Team < ApplicationRecord
  has_many :users
  has_many :tenhou_accounts
  has_many :team_logs
end
