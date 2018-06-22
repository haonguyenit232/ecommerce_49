class Product < ApplicationRecord
  belongs_to :category
  has_many :oder_details
  has_many :orders, through: :oder_details
  has_many :ratings
  has_many :comments

  mount_uploader :image, PictureUploader
  validates :title, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :description, presence: true, length: {maximum: Settings.description_max}
  validate  :picture_size

  scope :starts_with, ->(name){where "title like ?", "#{name}%"}
  scope :order_price, ->{order(price: :desc)}
  scope :recommended_product, ->{order rating: :desc}
  scope :name_sort, ->{order title: :asc}
  scope :newest_product, ->{order created_at: :desc}

  def update_rating_average
    rating_average = ratings.any? ? ratings.average(:starts).to_i : 0
    Product.update_attributes rating: rating_average
  end

  private

  def picture_size
    return unless image.size > Settings.max_image_size.megabytes
    errors.add :image, I18n.t("image_size")
  end
end
