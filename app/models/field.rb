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
      fields_with_attr = self.where("#{sort_column} IS NOT NULL")
      fields_without_attr = self.where("#{sort_column} IS NULL")
      return fields_with_attr.order("#{sort_column} #{sort_direction}") + fields_without_attr
    end
  end

  def location
    if !address.city
      return ""
    end

    return "#{address.city}, #{address.state}"
  end
end
