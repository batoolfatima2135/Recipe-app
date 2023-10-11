require 'rails_helper'

RSpec.describe 'foods/new', type: :view do
  before(:each) do
    user = User.first
    assign(:food, Food.new(
                    id: 1,
                    name: 'Test food',
                    quantity: 3,
                    measurement_unit: 'gm',
                    price: 120,
                    user:
                  ))
  end

  it 'renders new food form' do
    render

    assert_select 'form[action=?][method=?]', foods_path, 'post' do
      assert_select 'input[name=?]', 'food[name]'

      assert_select 'input[name=?]', 'food[measurement_unit]'

      assert_select 'input[name=?]', 'food[price]'

      assert_select 'input[name=?]', 'food[quantity]'
    end
  end
end
