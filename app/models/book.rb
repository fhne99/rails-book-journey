class Book < ApplicationRecord
  has_many :readings
  has_many :comments
  has_many :ratings
  has_many :book_libraries
  has_many :libraries, through: :book_libraries

  validates :title, presence: true, uniqueness: true
  validates :author, presence: true
end
