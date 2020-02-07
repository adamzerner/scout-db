class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :player_lists, dependent: :destroy

  def admin?
    self.role === "admin"
  end

  def read_access?
    self.role === "read"
  end
end
