class Comment < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  belongs_to :product
  has_many :reply_comments, class_name: Comment.name, foreign_key: :reply_to, dependent: :destroy
  has_one :parent, class_name: Comment.name, primary_key: :reply_to, foreign_key: :id

  validates :content, presence: true, length: {maximum: Settings.comment.max_length}

  delegate :name, to: :user, prefix: :user
end
