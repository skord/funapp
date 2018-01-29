class BooksController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @books = @category.books.page(params[:page])
    @best_sellers = @books.limit(5)
    @on_sale = @books.order("price asc").limit(5)
  end

  def show
    @category = Category.find(params[:category_id])
    @book = @category.books.find(params[:id])
    @similar_books = @category.books.order("RAND()").where.not(id: @book.id).limit(5)
  end
  def random
    @book = Book.order("RAND()").first
    @books = Book.order("RAND()").limit(3)
  end
end
