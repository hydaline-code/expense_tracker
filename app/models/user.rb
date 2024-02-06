class User < ApplicationRecord

  has_many :categories
  has_many :expenses, through: :categories

  validates :name, presence: true
end
