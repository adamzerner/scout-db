class Manager < ApplicationRecord
  belongs_to :team

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
