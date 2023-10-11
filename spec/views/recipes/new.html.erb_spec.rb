require 'rails_helper'

RSpec.describe 'recipes/new', type: :view do
  before(:each) do
    user = User.first
    assign(:recipe, Recipe.new(
                      name: 'MyString',
                      preparation_time: 1,
                      cooking_time: 1,
                      description: 'MyString',
                      public: false,
                      user: user
                    ))
  end

  it 'renders new recipe form' do
    render

    assert_select 'form[action=?][method=?]', recipes_path, 'post' do
      assert_select 'input[name=?]', 'recipe[name]'

      assert_select 'input[name=?]', 'recipe[preparation_time]'

      assert_select 'input[name=?]', 'recipe[cooking_time]'

      assert_select 'input[name=?]', 'recipe[description]'

    end
  end
end
