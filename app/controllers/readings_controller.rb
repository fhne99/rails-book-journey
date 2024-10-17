class ReadingsController < ApplicationController
  before_action :set_book, only: [:create]

  def create
    @reading = Reading.new(reading_params)
    @reading.book = @book
    @reading.user = current_user

    if @reading.save
      redirect_to @book, notice: 'Votre lecture a bien été enregistrée.'
    else
      redirect_to @book, alert: 'Une erreur est survenue lors de la création de votre lecture.'
    end
  end

  def update
    @book = Book.find(params[:book_id])
    @reading = @book.readings.find(params[:id])

    if @reading.update(reading_params)
      redirect_to @book, notice: 'Lecture mise à jour avec succès.'
    else
      render 'books/show', status: :unprocessable_entity
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def reading_params
    params.require(:reading).permit(:status, :start_date, :end_date, :number_pages_read)
  end
end
