class Product < ApplicationRecord
  acts_as_paranoid
  attr_accessor :quantity_in_cart
  belongs_to :category
  has_many :order_details
  has_many :orders, through: :order_details
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum del_flash: [:active, :inactive]
  delegate :name, to: :category, prefix: :category

  mount_uploader :image, PictureUploader
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :quantity, numericality: {greater_than_or_equal_to: Settings.min_quantity,
    only_integer: true}
  validates :description, presence: true, length: {maximum: Settings.description_max}
  validate  :picture_size

  scope :order_by_id, ->{order id: :desc}
  scope :order_price, ->{order(price: :desc)}
  scope :load_product_by_ids, ->(product_ids){where id: product_ids}
  scope :order_name, ->(order){order(name: order)}
  scope :min_max_price, ->(min, max){where("price >= ? AND price <= ?", min, max)}
  scope :by_category, ->(cate_ids){where category_id: cate_ids if cate_ids}
  scope :newest, ->{order(create_at: :desc)}
  scope :lastest_product, ->(number){order(created_at: :desc).limit(number)}

  def self.hot_product_by_month month
    product_ide = "SELECT `order_details`.`product_id`
                   FROM order_details
                   WHERE (order_details.created_at >= DATE_SUB(CURRENT_DATE(),INTERVAL " + month.to_s + " MONTH))
                   GROUP BY `order_details`.`product_id`
                   ORDER BY sum(order_details.quantity) DESC"
    Product.where("id IN (#{product_ide})").limit(Settings.product.limit)
  end

  def self.to_csv
    csv = ProductServices::ExportData.new()
    header = ["id", "name", "price", "description", "quantity", "status", "image", "category_id", "created_at", "updated_at", "rate_average", "del_flash"]
    head = ["id", "name", "price", "description", "quantity", "status", "image", "category_id", "created_at", "updated_at", "rate_average", "del_flash"]
    csv.export_csv(header, head, Product.all)
  end

  private

  def picture_size
    return unless image.size > Settings.max_image_size.megabytes
    errors.add :image, I18n.t("image_size")
  end

end
