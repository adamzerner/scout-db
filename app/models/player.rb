class Player < ApplicationRecord
  has_one :address, as: :addressable, dependent: :destroy
  belongs_to :high_school_team, class_name: "Team", optional: true
  belongs_to :club_team, class_name: "Team", optional: true

  accepts_nested_attributes_for :address, allow_destroy: true
  has_rich_text :notes

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_name_with_middle
    "#{first_name} #{middle_name} #{last_name}"
  end

  def display_height
    if !height
      return nil
    end

    return "#{feet_component_of_height}\"#{inches_component_of_height}"
  end

  def feet_component_of_height
    if !height
      return nil
    else
      (height / 12).floor
    end
  end

  def inches_component_of_height
    if !height
      return nil
    else
      return (height % 12).to_i
    end
  end

  def age
    if !birthday
      nil
    else
      ((Date.current - birthday).to_f / 365).round(2)
    end
  end

  def self.search(query)
    if query
      where("
        lower(first_name) LIKE ? OR
        lower(last_name) LIKE ?
      ", "%#{query.downcase}%", "%#{query.downcase}%")
    else
      all
    end
  end
end
