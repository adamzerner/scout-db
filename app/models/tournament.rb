class Tournament < ApplicationRecord
  has_many :games, inverse_of: :tournament, dependent: :destroy

  accepts_nested_attributes_for :games, allow_destroy: true

  def self.search(query)
    if query
      where("lower(name) LIKE ?", "%#{query.downcase}%")
    else
      all
    end
  end
end
