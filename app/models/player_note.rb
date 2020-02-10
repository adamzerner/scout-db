class PlayerNote < ApplicationRecord
  belongs_to :user
  belongs_to :player

  has_rich_text :notes
end
