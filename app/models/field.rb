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

  def self.sorted_fields(sort_column, sort_direction)
    if sort_column === "location"
      return self.all.left_joins(:address).order("addresses.city #{sort_direction}")
    else
      return self.all.order("#{sort_column} #{sort_direction}")
    end
  end

  def location
    if !address.city
      return ""
    end

    return "#{address.city}, #{address.state}"
  end
end
