require 'rails_helper'

RSpec.describe 'recipe_foods/new', type: :view do
  before(:each) do
    # Fetch or create a Recipe and Food record
    recipe = Recipe.first
    food = Food.first

    assign(:recipe_food, RecipeFood.new(
      quantity: 1,
      recipe: recipe,
      food: food
    ))
  end

  it 'renders new recipe_food form' do
    render

    assert_select 'form[action=?][method=?]', recipe_recipe_foods_path(recipe), 'post' do
      assert_select 'input[name=?]', 'recipe_food[quantity]'
    end
  end
end
