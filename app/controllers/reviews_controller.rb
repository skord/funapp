class ReviewsController < ApplicationController
  def index
    @book = Book.find(params[:book_id])
    @reviews = Review.where(book_id: params[:book_id]).order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new
  end

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new(review_params)
    @review.rating = rand(1..5)
    @review.reviewer_name = FFaker::Name.name
    if @review.save
      redirect_to category_book_url(@book.category, @book), notice: "Thanks #{@review.reviewer_name}! Review Submitted!"
    end
  end

  private

  def review_params
    params.require(:review).permit(:review)
  end
end
