class Game < ApplicationRecord
  belongs_to :tournament
  belongs_to :team_one, polymorphic: true
  belongs_to :team_two, polymorphic: true
  belongs_to :field, optional: true

  def name
    "#{team_one.name} vs #{team_two.name}"
  end

  def long_name
    "#{team_one.name} vs #{team_two.name} on #{date.to_formatted_s(:long)}"
  end
end
