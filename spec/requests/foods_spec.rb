require 'rails_helper'

RSpec.describe '/foods', type: :request do
  let(:user) { User.create!(email: 'testing@gmail.com', password: 'f4k3p455w0rd') }

  before(:each) do
    login_as(user, scope: :user)
  end

  describe 'GET /foods' do
    it 'renders a successful response' do
      get foods_url
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /foods/:id' do
    it 'renders a successful response' do
      food = Food.create(name: 'Rice', measurement_unit: 'kg', price: 10, quantity: 20, user:)
      get food_url(food)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /foods/new' do
    it 'renders a successful response' do
      get new_food_url
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /foods' do
    it 'creates a new food' do
      food_params = { name: 'Test Food', measurement_unit: 'kg', price: 10, quantity: 100 }

      expect do
        post foods_url, params: { food: food_params }
      end.to change(Food, :count).by(1)

      expect(response).to redirect_to(food_url(Food.last))
      follow_redirect!

      expect(response).to have_http_status(200)
      expect(response.body).to include('Food was successfully created.')
    end
  end

  describe 'DELETE /foods/:id' do
    it 'destroys the food' do
      food = Food.create(name: 'Rice', measurement_unit: 'kg', price: 10, quantity: 20, user:)

      expect do
        delete food_url(food)
      end.to change(Food, :count).by(-1)

      expect(response).to redirect_to(food_url)
    end
  end
end
