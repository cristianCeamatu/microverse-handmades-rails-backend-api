class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :items, dependent: :destroy
  has_many :favorite_items, dependent: :destroy
  has_many :favorites, through: :favorite_items, source: :item, dependent: :destroy
  has_one_attached :image

  validates :email, presence: true, length: { minimum: 6, maximum: 80 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, length: { minimum: 6, maximum: 80 }
  validates :nickname, presence: true, length: { minimum: 2, maximum: 20 }
  validates_uniqueness_of :email, on: :create
end
