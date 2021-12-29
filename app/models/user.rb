class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attachment :profile_image, destroy: false
  has_many :books
  has_many :favorites
  has_many :book_comments
  validates :name, presence: true, length: {maximum: 10, minimum: 2}
  validates :introduction, length: {maximum: 50}

  # フォロワー
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followee_id'
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # フォローしている人
  has_many :relationships, foreign_key: "follower_id"
  has_many :followings, through: :relationships, source: :followee
  
  # DM機能
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms
  has_many :chats, dependent: :destroy

  def following?(another_user)
    self.followings.include?(another_user)
  end
  
  def mutuals?(another_user)
    self.following?(another_user) && another_user.following?(self)
  end

  def follow(another_user)
    unless self == another_user
      self.relationships.find_or_create_by!(followee_id: another_user.id)
    end
  end

  def unfollow(another_user)
    unless self == another_user
      relationship = self.relationships.find_by(followee_id: another_user.id)
      relationship.destroy if relationship
    end
  end
  
  def room_with(another_user)
    rooms = Room.includes(:users)
    rooms.each do |room|
      users = room.users
      if users.include?(self) && users.include?(another_user)
        return room
      end
    end
    nil
  end

end