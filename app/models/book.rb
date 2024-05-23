class Book < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :author, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :comment, length: { maximum: 500 }

  enum status: { not_started: "Not started", in_progress: "In progress", finished: "Finished" }
  validates :status, inclusion: { in: statuses.keys }
end
