class Field < ApplicationRecord
  has_many :games
  has_one :address, as: :addressable, dependent: :destroy

  accepts_nested_attributes_for :address, allow_destroy: true
end