require 'rails_helper'

RSpec.feature 'Recipes public', type: :feature do
  let(:user) { User.create!(email: 'testing@gmail.com', password: 'f4k3p455w0rd') }
  let(:user2) { User.create!(email: 'testing2@gmail.com', password: 'f4k3p455w0rd') }

  before(:each) do
    login_as(user, scope: :user)
    @recipe1 = Recipe.create(name: 'Recipe 1', description: 'Description 1', preparation_time: 1, cooking_time: 2,
                             user:)
    @recipe2 = Recipe.create(name: 'Recipe 2', description: 'Description 2', preparation_time: 2, cooking_time: 3,
                             user:, public: true)
    @recipe3 = Recipe.create(name: 'Recipe 3', description: 'Description 4', preparation_time: 1, cooking_time: 3,
                             user: user2, public: true)
    visit '/'
  end
  scenario 'User views only public recipes' do
    expect(page).to have_content('Recipe 2')
    expect(page).to have_content('Recipe 3')
    expect(page).not_to have_content('Recipe 1')
  end

  scenario 'User views delete recipe button only if it is public and user is owner of recipe' do
    expect(page.all('button', text: 'Remove').count).to eq(1)
  end

  scenario 'User views recipe by click on description' do
    click_link(@recipe3.description)
    expect(page).to have_current_path(recipe_path(@recipe3))
  end

  scenario 'User deletes recipe by button' do
    first('button', text: 'Remove').click
    expect(page).not_to have_content(@recipe2.name)
    expect(page).not_to have_content(@recipe2.description)
    expect { Recipe.find(@recipe2.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
