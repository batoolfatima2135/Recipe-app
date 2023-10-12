# spec/requests/recipe_foods_controller_spec.rb
require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :request do
  let(:user) { User.create(email: 'a@example.com', password: 'password') }
  let(:recipe) do
    Recipe.create(user:, name: 'test', description: 'test description', cooking_time: 1, preparation_time: 1)
  end
  let(:food) { Food.create(user:, name: 'Example Food', quantity: 500, measurement_unit: 'gm', price: 1) }
  before(:each) do
    login_as(user, scope: :user)
  end

  describe 'GET /recipes/:recipe_id/recipe_foods/new' do
    it 'renders the new template' do
      get new_recipe_recipe_food_path(recipe)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET /recipes/:recipe_id/recipe_foods/:id/edit' do
    let(:recipe_food) { RecipeFood.create(quantity: 1, food:, recipe:) }

    it 'renders the edit template' do
      get edit_recipe_recipe_food_path(recipe, recipe_food)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST /recipes/:recipe_id/recipe_foods' do
    it 'creates a new recipe_food' do
      post recipe_recipe_foods_path(recipe), params: { recipe_food: { food_name: 'Example Food', quantity: 5 } }
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to eq('Recipe ingredient was successfully added.')
    end

    it "fails to create if food doesn't exist" do
      post recipe_recipe_foods_path(recipe), params: { recipe_food: { food_name: 'Non-Existent Food', quantity: 5 } }
      expect(response).to redirect_to(new_recipe_food_path(recipe))
      expect(flash[:alert]).to eq('Food not available, Add it first.')
    end
  end

  describe 'PATCH /recipes/:recipe_id/recipe_foods/:id' do
    let(:recipe_food) { RecipeFood.create(quantity: 1, food:, recipe:) }

    it 'updates the recipe_food' do
      recipe_food = RecipeFood.find_by(recipe_id: recipe.id, id: recipe_food.id)
      patch recipe_recipe_food_path(recipe, recipe_food), params: { recipe_food: { quantity: 10 } }
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to eq('Igredient quantity was successfully updated.')
    end
  end

  describe 'DELETE /recipes/:recipe_id/recipe_foods/:id' do
    let(:recipe_food) { RecipeFood.create(quantity: 1, food:, recipe:) }

    it 'destroys the recipe_food' do
      delete recipe_recipe_food_path(recipe, recipe_food)
      expect(response).to redirect_to(recipe_path(recipe))
      expect(flash[:notice]).to eq('Recipe ingredient was successfully removed.')
    end
  end
end
