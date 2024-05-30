module BooksHelper
  def status_icon(book)
    case book.status
    when 'lecture_en_attente'
      content_tag(:i, '', class: 'fa-regular fa-circle-xmark')
    when 'lecture_en_cours'
      content_tag(:i, '', class: 'fa-regular fa-clock')
    when 'lecture_terminée'
      content_tag(:i, '', class: 'fa-regular fa-circle-check')
    else
      content_tag(:i, '', class: 'fa fa-question status-icon default')
    end
  end
end
