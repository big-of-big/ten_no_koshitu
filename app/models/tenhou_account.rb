class TenhouAccount < ApplicationRecord
  belongs_to :team
  validates :name,
    presence: true,
    length: { maximum: 8 },
    uniqueness: { scope: :team_id }
  validate :correct_tenhou_account

  def correct_tenhou_account
    if [" ", "　", "(" ,")", "（" ,"）"].any? { |i| name.include?(i) }
      errors.add(:name, "に使用できない文字が含まれています")
    end
  end
end
