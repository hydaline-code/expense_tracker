require 'rails_helper'

RSpec.describe 'Testing categories views', type: :feature do
  before(:each) do
    @user = User.create(name: 'Test', email: 'text@example.com', password: '123456')
    @category = Category.create(name: 'Test category',
                                icon: 'https://cdn-icons-png.flaticon.com/128/2731/2731636.png', user: @user)
    @expense = Expense.create(name: 'Test payment', amount: 200, category: @category)

    visit new_user_session_path
    find('#email').set @user.email
    find('#floating_password').set @user.password
    click_on 'Log in'
  end

  describe 'categories#index' do
    it 'For each category, the user can see their name,
    icon and the total amount of all the transactions that belongs to that category.' do
      expect(page).to have_content 'Test category'
      expect(page).to have_content('$200.0')
    end

    it 'When the user clicks on category item it goes to show page for that category.' do
      click_on 'Test category'
      expect(current_path).to eq category_path(@category)
    end

    it 'There is a button "add a new category" at the bottom
    that brings the user to the page to create a new category.' do
      click_on 'New Category'
      expect(current_path).to eq new_category_path
    end
  end

  describe 'categories#show' do
    it 'For each expense, the user can see their name and the amount' do
      visit category_path(@category.id)
      expect(page).to have_content 'Test payment'
      expect(page).to have_content('$200.0')
    end
  end
end
