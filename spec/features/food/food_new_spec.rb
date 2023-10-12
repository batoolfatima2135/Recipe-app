require 'rails_helper'

RSpec.feature 'New Food', type: :feature do
  let(:user) { User.create!(email: 'testing@gmail.com', password: 'f4k3p455w0rd') }

  before do
    login_as(user, scope: :user)
    visit new_food_path
  end

  scenario 'User views the new food form' do
    expect(page).to have_content('New food')
    expect(page).to have_link('Back to foods')

    expect(page).to have_css('form')
    expect(page).to have_field('Name', type: 'text')
    expect(page).to have_field('Measurement unit', type: 'text')
    expect(page).to have_field('Unit Price', type: 'number')
    expect(page).to have_field('Quantity', type: 'number')
    expect(page).to have_button('Create Food')
  end

  scenario 'User creates a new food' do
    fill_in 'Name', with: 'New Test Food'
    fill_in 'Measurement unit', with: 'kg'
    fill_in 'Unit Price', with: 15
    fill_in 'Quantity', with: 10

    click_button 'Create Food'

    expect(page).to have_content('Food was successfully created.')
    expect(page).to have_current_path(food_path(Food.last))
    visit foods_path
    expect(page).to have_content('New Test Food')
  end
end