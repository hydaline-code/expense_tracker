require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
  describe 'GET /expenses' do
    before(:each) do
      @user = User.create(name: 'Test', email: 'text@example.com', password: '123456')
      @category = Category.create(name: 'Test category',
                                  icon: 'https://cdn-icons-png.flaticon.com/128/2731/2731636.png', user: @user)
      @expense = Expense.create(name: 'Test payment', amount: 200, category: @category)

      post user_session_path, params: { user: { email: @user.email, password: @user.password } }
      get root_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders correct template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /categories/:category_id/expenses/new' do
    before(:each) do
      @user = User.create(name: 'Test', email: 'text@example.com', password: '123456')
      @category = Category.create(name: 'Test category',
                                  icon: 'https://cdn-icons-png.flaticon.com/128/2731/2731636.png', user: @user)
      @expense = Expense.create(name: 'Test payment', amount: 200, category: @category)

      post user_session_path, params: { user: { email: @user.email, password: @user.password } }
      get root_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders correct template' do
      expect(response).to render_template(:index)
    end

    it 'renders correct content' do
      expect(response.body).to include('My Expense Tracker')
    end
  end
  end

