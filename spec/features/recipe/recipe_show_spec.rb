require 'rails_helper'

RSpec.feature 'Recipes index', type: :feature do
  let(:user) { User.create!(email: 'testing@gmail.com', password: 'f4k3p455w0rd') }

  before(:each) do
    login_as(user, scope: :user)
    @recipe = Recipe.create(name: 'Recipe 1', description: 'Description 1', preparation_time: 1, cooking_time: 2, user:)
    @food = Food.create(user: user, name: "banana", measurement_unit: "dozen", quantity: 5, price: 10)
    @ingredient = RecipeFood.create(recipe: @recipe, food: @food, quantity: 1)
    visit recipe_path(@recipe)
  end

  scenario 'show name of recipe' do
    expect(page).to have_content(@recipe.name)
  end

  scenario 'show prepration time of recipe' do
    expect(page).to have_content(@recipe.preparation_time)
  end

  scenario 'show cooking time of recipe' do
    expect(page).to have_content(@recipe.cooking_time)
  end

  scenario 'show description of recipe' do
    expect(page).to have_content(@recipe.description)
  end

  scenario 'show button to generate shopping list' do
    expect(page).to have_link("Generate shopping list")
  end

  scenario 'show button to add ingredient' do

    expect(page).to have_link("Add ingredient")
  end

  scenario 'Show ingredients' do
       
    expect(page).to have_content(@ingredient.food.name)
    expect(page).to have_content(@ingredient.quantity)
    expect(page).to have_content(@ingredient.food.price * @ingredient.quantity)
  end

  scenario 'show button to remove ingredient' do
    expect(page).to have_button("Remove")
  end

  scenario 'Click on remove button remove ingredient' do
     click_button("Remove")
     expect(page).not_to have_content(@ingredient.food.name)
     expect(page).not_to have_content('1 dozen')
     expect(page).not_to have_content('$10')
     expect{ RecipeFood.find(@ingredient.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  scenario 'Click on modify button open edit form' do
    click_link("Modify")
    expect(page).to have_current_path(edit_recipe_recipe_food_path(@recipe, @ingredient)) 
  end

  scenario 'show button to modify ingredient' do
    expect(page).to have_link("Modify")
  end

  scenario 'Add ingredient button click open form' do
    click_link("Add ingredient")
    expect(page).to have_current_path(new_recipe_recipe_food_path(@recipe))
  end

  scenario 'Add ingredient button click open form' do
    click_link("Generate shopping list")
    expect(page).to have_current_path(general_shoping_list_path)
  end

  scenario 'show button to modify ingredient' do
    expect(page).to have_link("Back to recipes")
  end

  scenario 'Click on modify button open edit form' do
    click_link("Back to recipes")
    expect(page).to have_current_path(recipes_path) 
  end

  scenario 'show button to remove recipe' do
    expect(page).to have_button("Remove recipe")
  end

  scenario 'Click button to remove recipe delete recipe' do
    click_button("Remove recipe")
    expect(page).to have_current_path(recipes_path) 
    expect{ Recipe.find(@recipe.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end