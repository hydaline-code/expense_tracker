require 'rails_helper'

RSpec.describe 'Testing expenses views', type: :feature do
  before(:each) do
    @user = User.create(name: 'Test', email: 'text@example.com', password: '123456')
    @category = Category.create(name: 'Test category',
                                icon: 'https://cdn-icons-png.flaticon.com/128/2731/2731636.png', user: @user)
    @expense = Expense.create(name: 'Test expense', amount: 200, category: @category)

    visit new_user_session_path
    find('#email').set @user.email
    find('#floating_password').set @user.password
    click_on 'Log in'
    visit category_path(@category.id)
    click_link('New Expense')
  end

  describe 'expenses on category#show' do
    it 'displays each expense with its name and amount' do
      visit category_path(@category)
      expect(page).to have_content 'Test expense'
      expect(page).to have_content '$200.0'
    end
  end

  it 'allows user to create a new expense with name and amount' do
    visit category_path(@category.id)

    expect(page).to have_content 'New Expense'
  end

  it 'displays the form for creating a new expense' do
    visit category_path(@category.id)
    click_link('New Expense')
    expect(page).to have_field('Name')
    expect(page).to have_field('Amount')
    select @category.name, from: 'Category'
    expect(page).to have_button('Save')
  end

  it 'creates a new expense when the form is submitted with valid data' do
    visit category_path(@category.id)
    click_link('New Expense')
    fill_in 'Name', with: 'Groceries'
    fill_in 'Amount', with: '50'
    click_button 'Save'

    expect(page).to have_content 'Expense was successfully created.'
    expect(page).to have_content 'Groceries'
    expect(page).to have_content '$50.0'
  end

  it 'displays an error message when the form is submitted with invalid data' do
    visit category_path(@category.id)
    click_link('New Expense')
    fill_in 'Name', with: ''
    fill_in 'Amount', with: ''
    click_button 'Save'
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Amount can't be blank"
  end
end
