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

  enum status: {normal: 0, hot: 1}
  scope :starts_with, ->(name){where "title like ?", "#{name}%"}
  scope :order_price, ->{order(price: :desc)}

  private

  def picture_size
    return unless image.size > Settings.max_image_size.megabytes
    errors.add :image, I18n.t("image_size")
  end
end
