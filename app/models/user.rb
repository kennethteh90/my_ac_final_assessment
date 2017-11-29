class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :notes

  has_many :active_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followees, through: :active_relationships

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :followee_id
  has_many :followers, through: :passive_relationships

  has_many :likes
  has_many :liked, class_name: 'Note', through: :likes, source: :note


  def follow(user)
    followees << user unless self.following?(user) || self == user
  end

  def following?(user)
    followees.include?(user)
  end

  def unfollow(user)
    followees.delete(user)
  end

  def like(note)
    liked << note unless self.liked?(note)
  end

  def liked?(note)
    liked.include?(note)
  end

  def unlike(note)
    liked.delete(note)
  end

end
