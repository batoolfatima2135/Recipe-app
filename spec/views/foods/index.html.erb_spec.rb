require 'rails_helper'

RSpec.describe 'foods/index', type: :view do
  before(:each) do
    user = User.first
    assign(:foods, [
             Food.create!(
               id: 1,
               name: 'Test',
               quantity: 3,
               measurement_unit: 'gm',
               price: 120,
               user:
             ),
             Food.create!(
               id: 2,
               name: 'Test',
               quantity: 3,
               measurement_unit: 'gm',
               price: 120,
               user:
             )
           ])
  end

  it 'renders a list of foods' do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new('Test'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('gm'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(120.to_s), count: 2
  end
end
