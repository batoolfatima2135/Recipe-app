require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create!(email: 'model@gmail.com', password: 'f4k3p455w0rd') }

  it 'is valid with valid attributes' do
    food = Food.create(name: 'Rice', measurement_unit: 'kg', price: 15, quantity: -3, user:)
    expect(food).to be_valid
  end

  it 'is not valid without name' do
    food = Food.create(measurement_unit: 'kg', price: 15, quantity: -3, user:)
    expect(food).not_to be_valid
  end

  it 'is not valid without measurement_unit' do
    food = Food.create(name: 'Rice', price: 15, quantity: -3, user:)
    expect(food).not_to be_valid
  end

  it 'is not valid without price' do
    food = Food.create(name: 'Rice', measurement_unit: 'kg', quantity: -3, user:)
    expect(food).not_to be_valid
  end

  it 'is not valid without quantity' do
    food = Food.create(name: 'Rice', measurement_unit: 'kg', price: 15, user:)
    expect(food).not_to be_valid
  end

  it 'is not valid without user' do
    food = Food.create(name: 'Rice', measurement_unit: 'kg', price: 15, quantity: -3)
    expect(food).not_to be_valid
  end
end
