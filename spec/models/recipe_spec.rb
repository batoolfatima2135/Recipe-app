require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before :all do
    @user = User.new(email: 'user@example.com', password: 'password123')
  end

  it 'is valid with valid attributes' do
    recipe = Recipe.new(user: @user, name: 'test', description: 'test description', cooking_time: 1,
                        preparation_time: 1)
    expect(recipe).to be_valid
  end

  it 'is not valid without name' do
    recipe = Recipe.new(user: @user, description: 'test description', cooking_time: 1, preparation_time: 1)
    expect(recipe).not_to be_valid
  end

  it 'is not valid without description' do
    recipe = Recipe.new(user: @user, name: 'test', cooking_time: 1, preparation_time: 1)
    expect(recipe).not_to be_valid
  end

  it 'is not valid without cooking_time' do
    recipe = Recipe.new(user: @user, name: 'test', description: 'test description', preparation_time: 1)
    expect(recipe).not_to be_valid
  end

  it 'is not valid without prepration_time' do
    recipe = Recipe.new(user: @user, name: 'test', description: 'test description', cooking_time: 1)
    expect(recipe).not_to be_valid
  end

  it 'is not valid without user' do
    recipe = Recipe.new(name: 'test', description: 'test description', cooking_time: 1, preparation_time: 1)
    expect(recipe).not_to be_valid
  end
end
