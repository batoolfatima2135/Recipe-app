require 'rails_helper'

RSpec.feature 'Recipes index', type: :feature do
  let(:user) { User.create!(email: 'testing@gmail.com', password: 'f4k3p455w0rd') }

  before(:each) do
    login_as(user, scope: :user)
    @recipe1 = Recipe.create(name: 'Recipe 1', description: 'Description 1', preparation_time: 1, cooking_time: 2,
                             user:)
    @recipe2 = Recipe.create(name: 'Recipe 2', description: 'Description 2', preparation_time: 2, cooking_time: 3,
                             user:)
    @recipe3 = Recipe.create(name: 'Recipe 3', description: 'Description 3', preparation_time: 1, cooking_time: 1,
                             user:)
    visit recipes_path
  end
  scenario 'User views their recipe list on index' do
    expect(page).to have_content('Recipe 2')
    expect(page).to have_content('Recipe 1')
  end

  scenario 'User views delete recipe button on index' do
    expect(page.all('button', text: 'Remove').count).to eq(3)
  end

  scenario 'User views recipe by click on description' do
    click_link(@recipe1.description)
    expect(page).to have_current_path(recipe_path(@recipe1))

    visit recipes_path
    click_link(@recipe2.description)
    expect(page).to have_current_path(recipe_path(@recipe2))

    visit recipes_path
    click_link(@recipe3.description)
    expect(page).to have_current_path(recipe_path(@recipe3))
  end

  scenario 'User deletes recipe by button' do
    first('button', text: 'Remove').click
    expect(page).not_to have_content(@recipe1.name)
    expect(page).not_to have_content(@recipe1.description)
    expect { Recipe.find(@recipe1.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
