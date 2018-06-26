class Product < ApplicationRecord
  attr_accessor :quantity_in_cart
  belongs_to :category
  has_many :order_details
  has_many :orders, through: :order_details
  has_many :ratings
  has_many :comments

  delegate :name, to: :category, prefix: :category

  mount_uploader :image, PictureUploader
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :description, presence: true, length: {maximum: Settings.description_max}
  validate  :picture_size

  scope :starts_with, ->(name){where "name like ?", "#{name}%"}
  scope :order_price, ->{order(price: :desc)}
  scope :load_product_by_ids, ->product_ids{where id: product_ids}
  enum del_flash: [:active, :inactive]

  private

  def picture_size
    return unless image.size > Settings.max_image_size.megabytes
    errors.add :image, I18n.t("image_size")
  end
end
