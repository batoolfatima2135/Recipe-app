require 'rails_helper'

RSpec.describe "recipes/new", type: :view do
  before(:each) do
    assign(:recipe, Recipe.new(
      name: "MyString",
      preparation-time: 1,
      cooking-time: 1,
      description: "MyString",
      public: false,
      user: nil
    ))
  end

  it "renders new recipe form" do
    render

    assert_select "form[action=?][method=?]", recipes_path, "post" do

      assert_select "input[name=?]", "recipe[name]"

      assert_select "input[name=?]", "recipe[preparation-time]"

      assert_select "input[name=?]", "recipe[cooking-time]"

      assert_select "input[name=?]", "recipe[description]"

      assert_select "input[name=?]", "recipe[public]"

      assert_select "input[name=?]", "recipe[user_id]"
    end
  end
end
