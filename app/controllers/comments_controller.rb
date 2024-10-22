class CommentsController < ApplicationController
  before_action :set_book
  before_action :set_comment, only: [:update, :destroy]

  def index
    @comments = current_user.comments
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.book = @book
    @comment.user = current_user

    if @comment.save
      redirect_to @book, notice: 'Votre commentaire a bien été enregistrée.'
    else
      redirect_to @book, alert: 'Une erreur est survenue lors de la création de votre commentaire.'
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @book, notice: 'Commentaire mis à jour avec succès.'
    else
      render 'books/show', status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to @book, notice: 'Commentaire supprimé avec succès.'
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_comment
    @comment = @book.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
