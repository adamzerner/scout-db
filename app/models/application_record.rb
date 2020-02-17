class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.ITEMS_PER_PAGE
    50.0 # important that it's a float because we need this for division
  end
end
