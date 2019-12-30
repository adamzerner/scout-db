class Game < ApplicationRecord
  belongs_to :tournament
  belongs_to :team_one, polymorphic: true
  belongs_to :team_two, polymorphic: true
  belongs_to :field, optional: true
end
