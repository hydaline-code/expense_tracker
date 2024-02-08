require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    @user = User.create(name: 'Hydaline', email: 'test@email', password: 'password')
    @category = Category.new(user_id: @user.id, name: 'My title', icon: 'https://www.flaticon.com/free-icon/person_2815428')
  end

  it 'if all attributes pass validation' do
    expect(@category).to be_valid
  end

  it 'if there is title' do
    @category.name = nil
    expect(@category).not_to be_valid
  end

  it 'if there is max 250 characters' do
    @category.name = 'Testing length'
    expect(@category).to be_valid
  end

  it 'if icon url is invalid' do
    @category.icon = nil
    expect(@category).not_to be_valid
  end

end
