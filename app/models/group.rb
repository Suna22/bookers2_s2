class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :mails, dependent: :destroy

  attachment :image, destroy: false

  def joined?(user)
    GroupUser.exists?(group_id: self.id, user_id: user.id)
  end

  def owned?(user)
    self.owner_id == user.id
  end
end
