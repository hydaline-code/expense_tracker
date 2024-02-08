require 'rails_helper'

RSpec.describe Expense, type: :model do
  before(:each) do
    @user = User.create(name: 'hydal', email: 'my@email', password: 'password')
    @category = Category.new(user_id: @user.id, name: 'My title', icon: 'https://www.flaticon.com/free-icon/person_2815428')
    @expense = Expense.create(category: @category, name: 'new payment', amount: 45)
  end

  it 'if all atributes pass validation' do
    expect( @expense).to be_valid
  end

  it 'if there is title' do
    @expense.name = nil
    expect( @expense).not_to be_valid
  end

  it 'if there is max 250 characters' do
    @expense.name = 'Testing lenght'
    expect( @expense).to be_valid
  end

  it 'if payment amount is invalid' do
    @expense.amount = nil
    expect( @expense).not_to be_valid
  end

  it 'if payment amount is number' do
    @expense.amount = 'not a number'
    expect( @expense).not_to be_valid
  end
end
