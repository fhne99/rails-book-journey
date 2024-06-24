class Rating < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :note, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
