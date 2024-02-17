require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }

  it 'is valid with valid attributes' do
    category = Category.new(name: 'Food', icon: 'https://example.com/icon.png', user:)
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    category = Category.new(name: nil, icon: 'https://example.com/icon.png', user:)
    expect(category).to_not be_valid
  end

  it 'is not valid without an icon' do
    category = Category.new(name: 'Food', icon: nil, user:)
    expect(category).to_not be_valid
  end

  it 'is not valid if name length exceeds 250 characters' do
    category = Category.new(name: 'a' * 251, icon: 'https://example.com/icon.png', user:)
    expect(category).to_not be_valid
  end

  it 'belongs to a user' do
    category = Category.reflect_on_association(:user)
    expect(category.macro).to eq(:belongs_to)
  end

  it 'has many expenses' do
    category = Category.reflect_on_association(:expenses)
    expect(category.macro).to eq(:has_many)
  end
end
