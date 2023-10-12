require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before :all do
    @recipe = Recipe.new(user: @user, name: 'test', description: 'test description', cooking_time: 1,
                         preparation_time: 1)
    @food = Food.new(name: 'test food', quantity: 500, measurement_unit: 'gm', price: 1)
  end

  it 'is valid with valid attributes' do
    recipe_food = RecipeFood.new(food: @food, quantity: 1, recipe: @recipe)
    expect(recipe_food).to be_valid
  end

  it 'is not valid without recipe' do
    recipe_food = RecipeFood.new(food: @food, quantity: 1)
    expect(recipe_food).not_to be_valid
  end

  it 'is not valid without food' do
    recipe_food = RecipeFood.new(quantity: 1, recipe: @recipe)
    expect(recipe_food).not_to be_valid
  end

  it 'is not valid without quantity' do
    recipe_food = RecipeFood.new(food: @food, recipe: @recipe)
    expect(recipe_food).not_to be_valid
  end
end
