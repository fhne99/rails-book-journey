class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def home
    @books = Book.order(created_at: :desc).limit(4)
  end

  def index
    @books = Book.all
  end

  def show; end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book), notice: 'Votre livre a bien été ajouté à vos lectures.'
    else
      render :new, status: :unprocessable_entity
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

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :start_date, :end_date, :rating, :comment, :cover_url, :status)
  end
end
