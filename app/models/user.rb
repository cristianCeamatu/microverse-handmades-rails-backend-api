class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true, length: { minimum: 6, maximum: 40 }
  validates :nickname, presence: true, length: { minimum: 6, maximum: 20 }

  has_many :items, dependent: :destroy
  has_many :favorite_items, dependent: :destroy
  has_many :favorites, through: :favorite_items, source: :item, dependent: :destroy
end
