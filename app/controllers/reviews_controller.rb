class ReviewsController < ApplicationController
  def index
    @book = Book.find(params[:book_id])
    @reviews = Review.where(book_id: params[:book_id]).page(params[:page]).per(5)
  end
end
