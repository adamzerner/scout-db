class Player < ApplicationRecord
  has_one :address, dependent: :destroy
  belongs_to :high_school_team, optional: true
  belongs_to :club_team, optional: true

  accepts_nested_attributes_for :address, allow_destroy: true
end
