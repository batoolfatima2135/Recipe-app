require 'rails_helper'

RSpec.describe 'recipe_foods/edit', type: :view do
 before(:each) do
    recipe = Recipe.first
    food = Food.first
    assign(:recipe_food, RecipeFood.new(
                           quantity: 1,
                           recipe: recipe,
                           food: food
                         ))
  end

  it 'renders the edit recipe_food form' do
    render

    assert_select 'form[action=?][method=?]', recipe_food_path(recipe_food), 'post' do
      assert_select 'input[name=?]', 'recipe_food[quantity]'
    end
  end
end
