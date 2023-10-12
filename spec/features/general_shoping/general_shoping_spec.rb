require 'rails_helper'

RSpec.feature 'General Shoping', type: :feature do
  let(:user) { User.create!(email: 'testing@gmail.com', password: 'f4k3p455w0rd') }
  let!(:food1) { Food.create(name: 'Rice', measurement_unit: 'kg', price: 15, quantity: -3, user:) }
  let!(:food2) { Food.create(name: 'Beef', measurement_unit: 'kg', price: 100, quantity: -10, user:) }
  let!(:foods) { [food1, food2] }

  before do
    login_as(user, scope: :user)
    visit general_shoping_list_path
  end

  scenario 'User views the General Shoping page' do
    expect(page).to have_content('General Shoping List')
    expect(page).to have_content('Amout Of Food Items to buy:')
    expect(page).to have_content('Total value of food:')
    expect(page).to have_css('table.table.table-success')
  end

  scenario 'User view the General Shoping list' do
    foods.each do |food|
      food.quantity = food.quantity.negative? ? food.quantity.abs : food.quantity
      expect(page).to have_content(food.name)
      expect(page).to have_content("#{food.quantity} #{food.measurement_unit}")
      expect(page).to have_content("$#{food.price * food.quantity}")
    end
  end
  scenario 'User clicks "Back to recipes" and is redirected to the recipes page' do
    click_link 'Back to recipes'
    expect(page).to have_current_path(recipes_path)
  end
end
