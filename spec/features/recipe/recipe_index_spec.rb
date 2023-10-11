require 'rails_helper'

RSpec.feature 'Recipes', type: :feature do
  let(:user) { User.create!(email: 'testing@gmail.com', password: 'f4k3p455w0rd') }

  before(:each) do
    login_as(user, scope: :user)
    Recipe.create(name: 'Recipe 1', description: 'Description 1', preparation_time: 1, cooking_time: 2, user: user)
    Recipe.create(name: 'Recipe 2', description: 'Description 2', preparation_time: 2, cooking_time: 3, user: user)
    Recipe.create(name: 'Recipe 3', description: 'Description 3', preparation_time: 1, cooking_time: 1, user: user)
  end
  scenario 'User views their recipe list on index' do
    
    visit recipes_path

    expect(page).to have_content('Recipe 2')
    expect(page).to have_content('Recipe 1')
  end

  scenario 'User views delete recipe button on index' do
    
    visit recipes_path
    
    expect(page.all('button', text: 'Remove').count).to eq(3)
  end

  # scenario 'User views a recipe on show' do
  #   recipe = user.recipes.create(name: 'Test Recipe', description: 'Test Description')

  #   visit recipe_path(recipe)

  #   expect(page).to have_content('Test Recipe')
  #   expect(page).to have_content('Test Description')
  # end

  # scenario 'User creates a new recipe' do
  #   # Manually sign in the user by creating a session
  #   visit new_user_session_path
  #   fill_in 'Email', with: user.email
  #   fill_in 'Password', with: 'password'
  #   click_button 'Log in'

  #   visit new_recipe_path

  #   fill_in 'Name', with: 'New Recipe'
  #   fill_in 'Description', with: 'Recipe Description'
  #   click_button 'Create Recipe'

  #   expect(page).to have_content('Recipe was successfully created.')
  #   expect(Recipe.last.name).to eq('New Recipe')
  # end
end
