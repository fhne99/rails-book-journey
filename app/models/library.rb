class Library < ApplicationRecord
  belongs_to :user
  has_many :book_libraries
  has_many :books, through: :book_libraries
end
