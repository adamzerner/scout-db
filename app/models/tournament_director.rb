class TournamentDirector < ApplicationRecord
  has_one :address, as: :addressable, dependent: :destroy
  belongs_to :tournament

  accepts_nested_attributes_for :address, allow_destroy: true

  def full_name
    if first_name && !first_name.empty? && last_name && !last_name.empty?
      return "#{first_name} #{last_name}"
    elsif first_name && !first_name.empty?
      return first_name
    elsif last_name && !last_name.empty?
      return last_name
    end
  end
end
