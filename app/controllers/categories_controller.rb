class CategoriesController < ApplicationController
  def index
    @categories = Category.all.order('name asc')
    @top_categories = Category.all.limit(15)
  end
end
