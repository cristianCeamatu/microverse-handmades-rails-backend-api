class Item < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 40 }
  validates :description, presence: true, length: { minimum: 6, maximum: 50_000 }
  validates :price, presence: true, length: { maximum: 12 }
  validates :usedFor, presence: true, length: { minimum: 2, maximum: 60 }

  belongs_to :user
  has_many :favorite_items, dependent: :destroy
  has_many :favorited_by, through: :favorite_items, source: :user, dependent: :destroy
end
