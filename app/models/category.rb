class Category < ApplicationRecord
  belongs_to :user
  has_many :expenses

  validates :name, presence: true, length: { maximum: 250 }
  validates :icon, presence: true, length: { maximum: 250 }
end
