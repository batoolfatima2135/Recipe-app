require 'rails_helper'

RSpec.feature 'Recipes index', type: :feature do
  let(:user) { User.create!(email: 'testing@gmail.com', password: 'f4k3p455w0rd') }

  before(:each) do
    login_as(user, scope: :user)
    @recipe = Recipe.create(name: 'Recipe 1', description: 'Description 1', preparation_time: 1, cooking_time: 2, user:)
    @food = Food.create(user:, name: 'banana', measurement_unit: 'dozen', quantity: 5, price: 10)
    @ingredient = RecipeFood.create(recipe: @recipe, food: @food, quantity: 1)
    visit recipe_path(@recipe)
  end

  scenario 'show button/link to add ingredient, remove ingredient and modify ingredient' do
    expect(page).to have_link('Add ingredient')
    expect(page).to have_link('Modify')
    expect(page).to have_button('Remove')
  end

  scenario 'Show ingredients' do
    expect(page).to have_content(@ingredient.food.name)
    expect(page).to have_content(@ingredient.quantity)
  end

  scenario 'Click on remove button remove ingredient' do
    click_button('Remove')
    expect(page).not_to have_content(@ingredient.food.name)
    expect { RecipeFood.find(@ingredient.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  scenario 'Click on modify button open edit form' do
    click_link('Modify')
    expect(page).to have_current_path(edit_recipe_recipe_food_path(@recipe, @ingredient))
  end

  scenario 'Add ingredient button click open form' do
    click_link('Add ingredient')
    expect(page).to have_current_path(new_recipe_recipe_food_path(@recipe))
  end
end
