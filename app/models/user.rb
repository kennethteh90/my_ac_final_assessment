class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]


  has_many :notes, dependent: :destroy

  has_many :active_relationships, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy
  has_many :followees, through: :active_relationships

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :followee_id, dependent: :destroy
  has_many :followers, through: :passive_relationships

  has_many :likes, dependent: :destroy
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

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

end
