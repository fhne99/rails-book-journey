class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def home
    @books = Book.order(created_at: :desc).limit(4) if user_signed_in?
  end

  def index
    @books = Book.all
  end

  def show
    @reading = @book.readings.find_or_initialize_by(user: current_user)
    @rating = @book.ratings.find_or_initialize_by(user: current_user)
    @comment = @book.comments.find_or_initialize_by(user: current_user)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book), notice: 'Votre livre a bien été ajouté à vos lectures.'
    else
      render :new, status: :unprocessable_entity, alert: 'Erreur lors de l\'ajout du livre. Veuillez réessayer.'
    end
  end

  def edit; end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'Votre lecture a bien été modifiée.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: 'Votre livre a bien été enlevé de vos lectures.', status: :see_other
  end

  def search_results
    @query = params[:q]
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :cover_url, :number_of_pages, :published_year)
  end
end
