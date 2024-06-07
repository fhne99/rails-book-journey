module BooksHelper
  def status_icon(book)
    case book.status
    when 'lecture_en_attente'
      content_tag(:i, '', class: 'fa-regular fa-circle-xmark status-icon')
    when 'lecture_en_cours'
      content_tag(:i, '', class: 'fa-regular fa-clock status-icon')
    when 'lecture_terminée'
      content_tag(:i, '', class: 'fa-regular fa-circle-check status-icon')
    else
      content_tag(:i, '', class: 'fa fa-question status-icon default status-icon')
    end
  end
end
