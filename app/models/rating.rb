class Rating < ApplicationRecord
  acts_as_paranoid
  belongs_to :product
  belongs_to :user

  after_save :update_product_rate_average

  validates :starts, presence: true, inclusion: Settings.rating.starts,
    numericality: {only_integer: true}

  scope :rating_average, ->(product_id){where(product_id: product_id).average(:starts)}

  private

  def update_product_rate_average
    product.rate_average = Rating.rating_average product_id
    product.save
  end
end
