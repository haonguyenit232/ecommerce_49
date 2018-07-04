class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_many :ratings
  has_many :comments
  has_many :suggests

  enum role: %i(member admin)

  scope :newest, ->{order created_at: :desc}

  def rating? product
    return ratings.find_by(product: product.id).nil? ? false : true
  end
end
