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

  context 'creating posts' do
    scenario 'prompts user to fill out a form, then displays the new post' do
      visit '/posts'
      click_link 'Add a post'
      fill_in 'Caption', with: 'Britney'
      click_button 'Create Post'
      expect(page).to have_content 'Britney'
      expect(current_path).to eq '/posts'
    end
  end

  context 'viewing posts' do

    let!(:britney){Post.create(caption:'Britney')}

    scenario 'lets a user view a post' do
      visit '/posts'
      click_link 'Britney'
      expect(page).to have_content 'Britney'
      expect(current_path).to eq "/posts/#{britney.id}"
    end
  end

  context 'editing posts' do

    before {Post.create caption: 'Britney'}

    scenario 'lets a user edit a post' do
      visit '/posts'
      click_link 'Edit Britney'
      fill_in 'Caption', with: 'Hit me baby one more time!'
      click_button 'Update Post'
      expect(page).to have_content 'Hit me baby one more time!'
      expect(current_path).to eq '/posts'
    end
  end

  context 'deleting posts' do

    before {Post.create caption: 'Britney'}

    scenario 'removes a post when a user clicks a delete link' do
      visit '/posts'
      click_link 'Delete Britney'
      expect(page).not_to have_content 'Britney'
      expect(page).to have_content 'Post deleted successfully'
    end
  end
end