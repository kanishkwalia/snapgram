require 'rails_helper'

feature 'posts' do
  context 'no posts have been added' do
    scenario 'should display a prompt to add a post' do
      visit '/posts'
      expect(page).to have_content 'No posts yet'
      expect(page).to have_link 'Add a post'
    end
  end

  context 'posts have been added' do
    before do
      Post.create(caption: 'Britney')
    end

    scenario 'display posts' do
      visit '/posts'
      expect(page).to have_content('Britney')
      expect(page).not_to have_content('No posts yet')
    end
  end
end