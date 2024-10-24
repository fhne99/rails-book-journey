class Reading < ApplicationRecord
  belongs_to :book
  belongs_to :user
  validates :number_pages_read, numericality: { less_than_or_equal_to: ->(reading) { reading.book.number_of_pages }, message: "ne peut pas être supérieur au nombre total de pages" }

  STATUSES = {
    not_started: "lecture_en_attente",
    in_progress: "lecture_en_cours",
    finished: "lecture_terminée"
  }.freeze
  validates :status, inclusion: { in: STATUSES.values }, presence: true

  def completion_percentage
    return 0 if book.number_of_pages.nil? || number_pages_read.nil? || book.number_of_pages == 0
    ((number_pages_read.to_f / book.number_of_pages) * 100).round(2)
  end

  def reading_duration
    case status
    when 'completed'
      if start_date && end_date
        (end_date - start_date).to_i
      end
    when 'in_progress'
      if start_date
        (Date.today - start_date).to_i
      end
    else
      0
    end
  end

  def validate_dates_based_on_status
    if status == 'not_started' && (start_date.present? || end_date.present?)
      errors.add(:base, "Vous ne pouvez pas entrer de dates pour une lecture en attente.")
    elsif status == 'in_progress' && end_date.present?
      errors.add(:end_date, "La date de fin ne doit pas être saisie tant que la lecture est en cours.")
    elsif status == 'completed' && (start_date.blank? || end_date.blank?)
      errors.add(:base, "Veuillez entrer les dates de début et de fin pour une lecture terminée.")
    end
  end
end
