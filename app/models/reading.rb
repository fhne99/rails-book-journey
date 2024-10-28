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

  def reading_time
    return "Pas de start_date" unless start_date.present?
    return "Pas de end_date pour completed" if status == "lecture_terminée" && end_date.blank?

    case status
    when "lecture_en_cours"
      "#{(Date.today - start_date).to_i} jours écoulés"
    when "lecture_terminée"
      "#{(end_date - start_date).to_i} jours de lecture"
    else
      "Statut non pris en charge pour le calcul du temps de lecture"
    end
  end
end
