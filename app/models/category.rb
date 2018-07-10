class Category < ApplicationRecord
  acts_as_paranoid
  has_many :products, dependent: :destroy
  has_many :subcategories, class_name: Category.name, foreign_key: :parent_category, dependent: :destroy
  has_one :parent, class_name: Category.name, primary_key: :parent_category, foreign_key: :id

  validates :name, presence: true, length: {maximum: Settings.category_max}

  scope :order_name, ->{order name: :asc}
end
