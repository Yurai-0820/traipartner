class Tag < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 100 }
  
  has_many :tag_relations, dependent: :destroy
  has_many :added_user, through: :tag_relations, source: :user
  has_many :chat_messages

  has_many :tag_users, dependent: :destroy
  has_many :chat_messages, dependent: :destroy

  def self.search(search)
    Tag.all unless search
    Tag.where(['title LIKE ?', "%#{search}%"])
  end
end
