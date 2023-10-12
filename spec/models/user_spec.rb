require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(email: 'new@example.com', password: 'password123')
    expect(user).to be_valid
    user.destroy if user.persisted?
  end

  it 'is not valid without an email' do
    user = User.new(password: 'password123')
    expect(user).not_to be_valid
  end

  it 'authenticates a user with a valid password' do
    user = User.create(email: 'user@example.com', password: 'password123')
    expect(user.valid_password?('password123')).to be true
  end

  it 'does not authenticate a user with an invalid password' do
    user = User.create(email: 'user@example.com', password: 'password123')
    expect(user.valid_password?('invalid_password')).to be false
  end
end
