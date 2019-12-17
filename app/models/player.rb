class Player < ApplicationRecord
  has_one :address, dependent: :destroy
  belongs_to :high_school_team, optional: true
  belongs_to :club_team, optional: true

  accepts_nested_attributes_for :address, allow_destroy: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def display_height
    "#{feet_component_of_height}\" #{inches_component_of_height}"
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
end
