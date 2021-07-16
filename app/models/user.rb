class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :sex
  belongs_to :prefecture
  has_one_attached :avatar

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
