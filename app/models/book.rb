class Book < ApplicationRecord
  has_many :readings
  has_and_belongs_to_many :libraries
  

  validates :title, presence: true, uniqueness: true
  validates :author, presence: true
end
