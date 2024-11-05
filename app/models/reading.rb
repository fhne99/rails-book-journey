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
    return "En attente de début" if start_date.nil?

    if end_date.nil?
      calculate_duration_between(start_date, Date.today)
    else
      calculate_duration_between(start_date, end_date)
    end
  end

  private

  def calculate_duration_between(start_date, end_date)
    years = end_date.year - start_date.year
    months = end_date.month - start_date.month
    days = end_date.day - start_date.day

    if days.negative?
      months -= 1
      days += (end_date - end_date.prev_month).to_i
    end

    if months.negative?
      years -= 1
      months += 12
    end

    format_duration(years, months, days)
  end

  def format_duration(years, months, days)
    [].tap do |parts|
      parts << "#{years} ans#{'s' if years > 1}" if years.positive?
      parts << "#{months} mois" if months.positive?
      parts << "#{days} jour#{'s' if days > 1}" if days.positive?
    end.join(", ")
  end
end
