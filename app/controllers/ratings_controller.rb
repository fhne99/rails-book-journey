class RatingsController < ApplicationController
  before_action :set_book
  before_action :set_rating, only: [:update, :destroy]

  def index
    @ratings = current_user.ratings
  end

  def create
    @rating = Rating.new(rating_params)
    @rating.book = @book
    @rating.user = current_user

    if @rating.save
      redirect_to @book, notice: 'Votre lecture a bien été enregistrée.'
    else
      redirect_to @book, alert: 'Une erreur est survenue lors de la création de votre lecture.'
    end
  end

  def update
    if @rating.update(rating_params)
      redirect_to @book, notice: 'Lecture mise à jour avec succès.'
    else
      render 'books/show', status: :unprocessable_entity
    end
  end

  def destroy
    @rating.destroy
    redirect_to @book, notice: 'Lecture supprimée avec succès.'
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_rating
    @rating = @book.ratings.find(params[:id])
  end

  def rating_params
    params.require(:rating).permit(:note)
  end
end
