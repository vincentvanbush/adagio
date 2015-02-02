class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :create]

  expose_decorated :categories
  expose_decorated :category

  def new
  end

  def create
  end

  def index
  end

  def destroy
    category.destroy
    redirect_to categories_url
  end

  def update
  end

  def edit
  end
end
