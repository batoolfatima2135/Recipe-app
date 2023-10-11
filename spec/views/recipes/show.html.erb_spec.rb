require 'rails_helper'

RSpec.describe 'recipes/show', type: :view do
  include Devise::Test::ControllerHelpers
  before(:each) do
    user = User.first
    assign(:recipe, Recipe.create!(
                      name: 'Name',
                      preparation_time: 2,
                      cooking_time: 3,
                      description: 'Description',
                      public: false,
                      user:
                    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Description/)
  end
end
