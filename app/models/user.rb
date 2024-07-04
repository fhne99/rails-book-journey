class User < ApplicationRecord
  has_one :library
  has_one :wishlists
  has_many :readings
  has_many :books, through: :library
  has_many :books, through: :wishlists
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
