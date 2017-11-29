class Note < ApplicationRecord

  belongs_to :user

  has_many :likes
  has_many :likers, class_name: 'User', through: :likes

end
