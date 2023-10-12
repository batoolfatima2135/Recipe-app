require 'rails_helper'

RSpec.feature 'Recipes show', type: :feature do
  let(:user) { User.create!(email: 'testing@gmail.com', password: 'f4k3p455w0rd') }

  before(:each) do
    login_as(user, scope: :user)
    @recipe = Recipe.create(name: 'Recipe 1', description: 'Description 1', preparation_time: 1, cooking_time: 2, user:)
    @food = Food.create(user:, name: 'banana', measurement_unit: 'dozen', quantity: 5, price: 10)
    visit recipe_path(@recipe)
  end

  scenario 'show name, prepration time, cooking time and desription of recipe' do
    expect(page).to have_content(@recipe.name).and have_content(@recipe.preparation_time)
    expect(page).to have_content(@recipe.cooking_time).and have_content(@recipe.description)
  end

  scenario 'show button/link to generate shopping list, remove recipe and Back to recipes' do
    expect(page).to have_link('Generate shopping list')
    expect(page).to have_button('Remove recipe')
    expect(page).to have_link('Back to recipes')
  end

  scenario 'Generate shopping list click open list' do
    click_link('Generate shopping list')
    expect(page).to have_current_path(general_shoping_list_path)
  end

  scenario 'Click on Back to recipes button takes back to recipe page' do
    click_link('Back to recipes')
    expect(page).to have_current_path(recipes_path)
  end

  scenario 'Click button to remove recipe delete recipe' do
    click_button('Remove recipe')
    expect(page).to have_current_path(recipes_path)
    expect { Recipe.find(@recipe.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
