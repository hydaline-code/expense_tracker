class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i[show edit update destroy]
  before_action :set_category


  def index
    @expenses = @category.expenses.order(created_at: :desc)
    @total_amount = @category.expenses.sum(:amount)
  end


  def show; end

  def new
    @category = Category.find(params[:category_id])
    @expense = @category.expenses.new
  end

  def edit
    @categories = current_user.categories
  end


  def create
    @expense = current_user.expenses.new(expense_params)

    if @expense.save
      redirect_to category_expenses_path(@expense.category), notice: 'Expense was successfully created.'
    else
      puts @expense.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @expense.update(expense_params)
      redirect_to @expense, notice: 'Expense was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @expense.destroy
    redirect_to expenses_url, notice: 'Expense was successfully destroyed.'
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Category not found'
    redirect_to categories_path
  end

  
  def set_expense
    @expense = current_user.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:category_id, :name, :amount)
  end
end
