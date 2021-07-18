class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :sex
  belongs_to :prefecture
  has_one_attached :avatar

  has_many :posts, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :chat_messages
  
  has_many :tag_relations
  has_many :adding_tags, through: :tag_relations, source: :tag
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :from_messages, class_name: "Message", foreign_key: "from_id", dependent: :destroy
  has_many :to_messages, class_name: "Message", foreign_key: "to_id", dependent: :destroy
  has_many :sent_messages, through: :from_messages, source: :from
  has_many :received_messages, through: :to_messages, source: :to

  def adding(tag)
    unless self.tag_relations.include?(tag)
      self.tag_relations.find_or_create_by(tag_id: tag.id)
    end
  end

  def remove(tag)
    delete_tag = self.tag_relations.find_by(tag_id: tag.id)
    delete_tag.destroy if delete_tag
  end

  def adding?(tag)
    self.adding_tags.include?(tag)
  end
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def send_message(other_user, room_id, content)
    from_messages.create!(to_id: other_user.id, room_id: room_id, content: content)
  end


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         with_options presence: true do
          validates :nickname
          validates :gymnasium
          validates :age, format: { with: /\A[0-9]+\z/, message: 'is invalid. input harf-width characters.' }
          with_options numericality: { other_than: 0 } do
            validates :sex_id
            validates :prefecture_id
          end
        end

end
