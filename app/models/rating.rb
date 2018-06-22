class Rating < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :starts,
    numericality: {
      greater_than_or_equal_to: Settings.rating.min_point,
      less_than_or_equal_to: Settings.rating.max_point
    }
end
