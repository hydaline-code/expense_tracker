class Expense < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, length: { maximum: 250 }
  validates :amount, presence: true, numericality: { only_decimal: true, greater_than_or_equal_to: 0 }

  private

  def validate_amount_format
    if amount.present? && (amount.to_s =~ /\A[+-]?\d+(\.\d+)?\z/).nil?
      errors.add(:amount, "must be a valid number")
    end

    if amount.present? && amount.to_f > 1_000_000
      errors.add(:amount, "cannot exceed 1,000,000")
    end
  end
end
