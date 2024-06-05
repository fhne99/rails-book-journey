class Book < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :author, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :comment, length: { maximum: 500 }

  STATUSES = {
    not_started: "lecture_en_attente",
    in_progress: "lecture_en_cours",
    finished: "lecture_terminée"
  }.freeze
  validates :status, inclusion: { in: STATUSES.values }, presence: true
end
