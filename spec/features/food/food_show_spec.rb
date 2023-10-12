require 'rails_helper'

RSpec.feature 'Foods Show page', type: :feature do
  let(:user) { User.create!(email: 'testing@gmail.com', password: 'f4k3p455w0rd') }
  let(:food) { Food.create(name: 'Rice', measurement_unit: 'kg', price: 10, quantity: 20, user:) }

  before(:each) do
    login_as(user, scope: :user)
    visit foods_path(food)
  end
  scenario 'User views their Food details on show page' do
    expect(page).to have_content('Rice')
  end

  scenario 'User views delete Food button on index' do
    expect(page.all('button', text: 'Destroy this food').count).to eq(1)
  end
end
