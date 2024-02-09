class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, except: [:index]

  # GET /expenses
  # def index
  #   @expenses = Expense.all
  #   @total_amount = @expenses.sum(:amount)
  # end

  # GET /categories/:category_id/expenses
  def index
    @expenses = Expense.order(created_at: :desc)
    @total_amount =@expenses.sum(:amount)
  end

  # GET /categories/:category_id/expenses/new
  def new
    @category = Category.find(params[:category_id])
    @expense = Expense.new
  end

  # POST /categories/:category_id/expenses
  def create
    @expense = @category.expenses.new(expense_params)

    if @expense.save
      redirect_to category_expenses_path(@category), notice: 'Expense was successfully created.'
    else
      flash.now[:alert] = 'Failed to create expense. Please check the form and try again.'
      render :new
    end
  end

  private

  def set_category
    @category = current_user.categories.find_by(id: params[:category_id])
    if @category.nil?
      flash[:alert] = "Category not found"
      redirect_to root_path
    end
  end
  

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end
