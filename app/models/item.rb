class Item < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_many :favorite_items, dependent: :destroy
  has_many :favorited_by, through: :favorite_items, source: :user, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true, length: { minimum: 2, maximum: 40 }
  validates :description, presence: true, length: { minimum: 6, maximum: 50_000 }
  validates :price, presence: true, length: { maximum: 12 }
  validates :usedFor, presence: true, length: { minimum: 2, maximum: 60 }
  validates :image, presence: true

  def image_url
    image.nil? ? nil : url_for(image)
  end
end
