class Expense < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, length: { maximum: 250 }
  validates :amount, presence: true, numericality: { only_decimal: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10_000, message: "must be less than or equal to 10,000" }
  
end
