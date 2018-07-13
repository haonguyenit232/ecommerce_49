class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]

  has_many :orders
  has_many :ratings
  has_many :comments
  has_many :suggests

  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness: true, presence: true

  enum role: %i(member admin)
  scope :newest, ->{order created_at: :desc}

  def rating? product
    return ratings.find_by(product: product.id).nil? ? false : true
  end

  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end

  def self.new_with_session params, session
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
