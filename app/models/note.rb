class Note < ApplicationRecord

  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :likers, class_name: 'User', through: :likes

  validates :title, presence: true
  validates :body, presence: true

end
