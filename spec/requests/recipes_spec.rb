require 'rails_helper'

RSpec.describe '/recipes', type: :request do

  let(:user) { User.create(email: 'abc@example.com', password: 'password') }

  let(:valid_attributes) do
    {
      name: 'test',
      description: 'Testing',
      cooking_time: 1,
      preparation_time: 2,
      user: user
    }
  end

  let(:invalid_attributes) do
    {
      name: 'test',
      description: 'Testing',
      cooking_time: 1,
      preparation_time: 2
    }
  end

   before(:each) do
    login_as(user, scope: :user)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Recipe.create! valid_attributes
      get recipes_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      recipe = Recipe.create! valid_attributes
      get recipe_url(recipe)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_recipe_url
      expect(response).to be_successful
    end
  end

  # describe 'POST /create' do
  #   context 'with valid parameters' do
  #     it 'creates a new Recipe' do
  #       expect do
  #         post recipes_url, params: { recipe: valid_attributes }
  #       end
  #     end

  #     it 'redirects to the created recipe' do
  #       post recipes_url, params: { recipe: valid_attributes }
  #       expect(response).to redirect_to(recipe_url(Recipe.last))
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it 'does not create a new Recipe' do
  #       expect do
  #         post recipes_url, params: { recipe: invalid_attributes }
  #       end
  #     end

  #     it "renders a response with 422 status (i.e. to display the 'new' template)" do
  #       post recipes_url, params: { recipe: invalid_attributes }
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #   end
  # end

  # describe 'PATCH /update' do
  #   context 'with valid parameters' do
  #     let(:new_attributes) do
  #       {
  #     name: 'new test',
  #     description: 'Testing',
  #     cooking_time: 1,
  #     preparation_time: 2,
  #   }
  #     end

  #     it 'updates the requested recipe' do
  #       recipe = Recipe.create! valid_attributes
  #       patch recipe_url(recipe), params: { recipe: new_attributes }
  #       recipe.reload
  #       skip('Add assertions for updated state')
  #     end

  #     it 'redirects to the recipe' do
  #       recipe = Recipe.create! valid_attributes
  #       patch recipe_url(recipe), params: { recipe: new_attributes }
  #       recipe.reload
  #       expect(response).to redirect_to(recipe_url(recipe))
  #     end
  #   end

  #   context 'with invalid parameters' do
  #     it "renders a response with 422 status (i.e. to display the 'edit' template)" do
  #       recipe = Recipe.create! valid_attributes
  #       patch recipe_url(recipe), params: { recipe: invalid_attributes }
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end
  #   end
  # end

  # describe 'DELETE /destroy' do
  #   it 'destroys the requested recipe' do
  #     recipe = Recipe.create! valid_attributes
  #     expect do
  #       delete recipe_url(recipe)
  #     end
  #   end

  #   it 'redirects to the recipes list' do
  #     recipe = Recipe.create! valid_attributes
  #     delete recipe_url(recipe)
  #     expect(response).to redirect_to(recipes_url)
  #   end
  # end
end
