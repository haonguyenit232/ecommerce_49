class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  has_many :products, through: :order_details

  enum status: {cancelled: 0, in_progress: 1, rejected: 2, approved: 3}
end
