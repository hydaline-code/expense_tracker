require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:category) { Category.create(name: "Test Category", icon: "https://example.com/icon.png") }

  it "is valid with valid attributes" do
    expense = Expense.new(name: "Test Expense", amount: 100, category: category)
    expect(expense).to be_valid
  end

  it "is not valid without a name" do
    expense = Expense.new(amount: 100, category: category)
    expect(expense).not_to be_valid
  end

  it "is not valid without an amount" do
    expense = Expense.new(name: "Test Expense", category: category)
    expect(expense).not_to be_valid
  end

  it "is not valid if amount is not a number" do
    expense = Expense.new(name: "Test Expense", amount: "invalid", category: category)
    expect(expense).not_to be_valid
  end

  it "is not valid if amount is less than 0" do
    expense = Expense.new(name: "Test Expense", amount: -100, category: category)
    expect(expense).not_to be_valid
  end

  it "is not valid if amount is greater than 10,000" do
    expense = Expense.new(name: "Test Expense", amount: 20_000, category: category)
    expect(expense).not_to be_valid
  end

  it "belongs to a category" do
    association = Expense.reflect_on_association(:category)
    expect(association.macro).to eq(:belongs_to)
  end
end

