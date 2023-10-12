require 'rails_helper'

RSpec.feature 'Foods Index Page', type: :feature do
  let(:user) { User.create!(email: 'testing@gmail.com', password: 'f4k3p455w0rd') }

  before(:each) do
    login_as(user, scope: :user)
    Food.create(name: 'Rice', measurement_unit: 'kg', price: 10, quantity: 20, user:)
    Food.create(name: 'Chicken', measurement_unit: 'kg', price: 30, quantity: 10, user:)
    Food.create(name: 'Beef', measurement_unit: 'kg', price: 50, quantity: 10, user:)
    visit foods_path
  end
  scenario 'User views their Food list on index' do
    expect(page).to have_content('Rice')
    expect(page).to have_content('Chicken')
  end

  scenario 'User views delete Food button on index' do
    foods = Food.where(user:)
    foods.each do |food|
      expect(page).to have_selector("button[data-food-id='#{food.id}']", text: 'Destroy this food')
    end
  end
  scenario 'User clicks on a New Food and is redirected to their New Food page' do
    click_link 'New Food'
    expect(page).to have_current_path(new_food_path)
  end
end