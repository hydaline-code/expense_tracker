class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = current_user.categories.includes(:expenses).order(created_at: :desc)
  end

  def show
    @category = Category.find(params[:id])
    @expenses = @category.expenses.order(created_at: :desc)
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to root_path, flash: { success: 'Category was successfully destroyed.' }
  end

  private

  def set_category
    @category = current_user.categories.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Category not found'
    redirect_to categories_path
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
