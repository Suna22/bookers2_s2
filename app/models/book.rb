class Book < ApplicationRecord
	belongs_to :user
	validates :title, presence: true
	validates :body ,presence: true, length: {maximum: 200}

  has_many :favorites
  has_many :book_comments

  def favorited_by?(user)
    Favorite.where(user_id: user.id, book_id: self.id).exists?
  end

  def self.term(time1, time2=nil)
    unless time2
      time2 = time1 + 1
    end
    self.where("? < created_at and created_at < ?", time1, time2)
  end
end
