class Field < ApplicationRecord
  has_many :games, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy

  accepts_nested_attributes_for :address, allow_destroy: true

  def self.search(query)
    if query
      where("lower(name) LIKE ?", "%#{query.downcase}%")
    else
      all
    end
  end
end
