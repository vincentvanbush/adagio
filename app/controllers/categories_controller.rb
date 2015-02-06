class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]

  expose_decorated :categories
  expose_decorated :category

  def new
  end

  def create
    self.category = Category.new(category_params)
    category.title = category_params['title']

    if category.save
      categories << category
      redirect_to root_url, notice: 'Category successfully created'
    else
      render 'categories/new'
    end
  end

  def index
  end

  def destroy
    category.destroy
    redirect_to categories_url
  end

  def update
    self.category = Category.find(params['id'])
    if category.update(category_params)
      redirect_to root_url, notice: 'Category successfully renamed'
    else
      render 'categories/edit'
    end
  end

  def edit
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end
