 require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET /index' do
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
      expect(response.body).to include('categories')
      expect(response.body).to include('Test category')
      expect(response.body).to include('$200.0')
    end
  end

  describe 'GET /new' do
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
      expect(response.body).to include('CATEGORIES')
    end
  end
end

# RSpec.describe CategoriesController, type: :request do
#   describe "GET #index" do
#     it "returns http success" do
#       user = create(:user)
#       sign_in user
#       get categories_path
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe "GET #show" do
#     it "returns http success" do
#       user = create(:user)
#       sign_in user
#       category = create(:category, user: user)
#       get category_path(category)
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe "GET #new" do
#     it "returns http success" do
#       user = create(:user)
#       sign_in user
#       get new_category_path
#       expect(response).to have_http_status(:success)
#     end
#   end

#   describe "POST #create" do
#     context "with valid parameters" do
#       it "creates a new category" do
#         user = create(:user)
#         sign_in user
#         expect {
#           post categories_path, params: { category: attributes_for(:category) }
#         }.to change(Category, :count).by(1)
#       end
#     end

#     context "with invalid parameters" do
#       it "does not create a new category" do
#         user = create(:user)
#         sign_in user
#         expect {
#           post categories_path, params: { category: attributes_for(:category, name: nil) }
#         }.not_to change(Category, :count)
#       end
#     end
#   end

#   describe "PATCH #update" do
#     context "with valid parameters" do
#       it "updates the category" do
#         user = create(:user)
#         sign_in user
#         category = create(:category, user: user)
#         patch category_path(category), params: { category: { name: "New Name" } }
#         expect(category.reload.name).to eq("New Name")
#       end
#     end

#     context "with invalid parameters" do
#       it "does not update the category" do
#         user = create(:user)
#         sign_in user
#         category = create(:category, user: user)
#         patch category_path(category), params: { category: { name: nil } }
#         expect(category.reload.name).not_to be_nil
#       end
#     end
#   end

#   describe "DELETE #destroy" do
#     it "destroys the category" do
#       user = create(:user)
#       sign_in user
#       category = create(:category, user: user)
#       expect {
#         delete category_path(category)
#       }.to change(Category, :count).by(-1)
#     end
#   end
# end
