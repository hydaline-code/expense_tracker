# require 'rails_helper'

# RSpec.describe User, type: :model do
#   describe 'User model' do
#     before(:each) do
#       @user = User.new(name: 'chacha', email: 'charlenei@gmail.com', password: 'password')
#     end

#     before { @user.save }

#     it 'name must not be blank' do
#       @user.name = nil
#       expect(@user).to_not be_valid
#     end

#     it 'email must not be blank' do
#       @user.email = ''
#       expect(@user).to_not be_valid
#     end

#     it 'password must not be blank' do
#       @user.password = ''
#       expect(@user).to_not be_valid
#     end
#   end
# end
require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(
      name: "Test User",
      email: "test@example.com",
      password: "password"
    )
    expect(user).to be_valid
  end

  it "is not valid without a name" do
    user = User.new(name: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without an email" do
    user = User.new(email: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without a password" do
    user = User.new(password: nil)
    expect(user).to_not be_valid
  end

  it "has many categories" do
    user = User.reflect_on_association(:categories)
    expect(user.macro).to eq(:has_many)
  end

  it "has many expenses through categories" do
    user = User.reflect_on_association(:expenses)
    expect(user.macro).to eq(:has_many)
  end
end
