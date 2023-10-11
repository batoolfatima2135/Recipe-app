require 'rails_helper'

RSpec.describe 'foods/show', type: :view do
  before(:each) do
    user = User.first
    assign(:food, Food.create!(
                   id: 1,
      name: 'Test food',
      quantity: 3,
      measurement_unit: 'gm',
      price: 120,
      user: user
                  ))
  end

  it 'renders attributes in <td>' do
    render
    expect(rendered).to match(/Test food/)
    expect(rendered).to match(/gm/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/120/)
  end
end
