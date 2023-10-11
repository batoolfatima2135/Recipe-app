require 'rails_helper'

RSpec.describe 'recipes/index', type: :view do
  include Devise::Test::ControllerHelpers 
  before(:each) do
    user = User.first
    assign(:recipes, [
             Recipe.create!(
               name: 'Name',
               preparation_time: 2,
               cooking_time: 3,
               description: 'Description',
               public: false,
               user: user
             ),
             Recipe.create!(
               name: 'Name',
               preparation_time: 2,
               cooking_time: 3,
               description: 'Description',
               public: false,
               user: user
             )
           ])
  end

  it 'renders a list of recipes' do
    render
    cell_selector = 'div>p' 
    assert_select cell_selector, text: Regexp.new('Name'.to_s), count: 2
    cell_selector_description = 'div>a>p'
    assert_select cell_selector_description, text: Regexp.new('Description'.to_s), count: 2
    
  end
end
