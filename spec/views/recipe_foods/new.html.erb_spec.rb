require 'rails_helper'

RSpec.describe 'recipe_foods/new', type: :view do
  let!(:recipe) do
    Recipe.create(
      id: 1,
      name: 'Test Recipe',
      preparation_time: 1.5,
      cooking_time: 2.5,
      description: 'Testing Recipe',
      public: true,
      user_id: 1
    )
  end
  let!(:food) do
    Food.create(
      id: 1,
      name: 'Test food',
      quantity: 3,
      measurement_unit: 'gm',
      price: 120,
      user_id: 1
    )
  end
  before(:each) do
    assign(:recipe, recipe)
    assign(:recipe_food, RecipeFood.new(
                           quantity: 1,
                           recipe:,
                           food:
                         ))
  end

  it 'renders new recipe_food form' do
    render

    assert_select 'form[action=?][method=?]', recipe_foods_path(@recipe_food), 'post' do
      assert_select 'input[name=?]', 'recipe_food[quantity]'
    end
  end
end
