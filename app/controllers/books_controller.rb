class BooksController < ApplicationController
  before_action :set_event, only: [:show, :destroy]


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

  def destroy
    @book.destroy
    redirect_to books_path, notice: 'Votre livre a bien été enlevé de vos lectures.', status: :see_other
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :start_date, :end_date, :rating, :comment)
  end
end
