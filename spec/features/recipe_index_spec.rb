require 'rails_helper'

RSpec.feature 'Post Show Page' do
  let!(:user1) { User.create(name: 'Mike', bio: 'this is test bio', email: 'abc@gmail.com', password: 123_456, photo: 'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500') }
  let!(:recipe1) = Recipe.new(user: @user, name: 'test', description: 'test description', cooking_time: 1, preparation_time: 1)
  let!(:user1) { User.create(name: 'Mike', bio: 'this is test bio', email: 'abc@gmail.com', password: 123_456, photo: 'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500') }
  let!(:recipe) = Recipe.new(user: @user, name: 'test', description: 'test description', cooking_time: 1, preparation_time: 1)

  scenario 'Displays post title and author' do
    visit user_post_path(user1, post1)

    expect(page).to have_content(post1.title)
    expect(page).to have_content(user1.name)
  end

  scenario 'Displays how many comments and likes the post has' do
    visit user_post_path(user1, post1)

    expect(page).to have_content("Comments: #{post1.comments.count}")
    expect(page).to have_content("Likes: #{post1.likes.count}")
  end

  scenario 'Displays the post body' do
    visit user_post_path(user1, post1)

    expect(page).to have_content('This is the body of the post.')
  end

  scenario 'Displays the username of each commentor' do
    visit user_post_path(user1, post1)

    expect(page).to have_content(comment1.user.name)
    expect(page).to have_content(comment2.user.name)
  end

  scenario 'Displays the comment left by each commentor' do
    visit user_post_path(user1, post1)

    expect(page).to have_content(comment1.text)
    expect(page).to have_content(comment2.text)
  end
end
