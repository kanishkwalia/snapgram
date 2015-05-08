require 'rails_helper'

feature 'leaving comments on posts ' do
  before {Post.create caption: 'Britney'}

  scenario 'allows users to leave a comment on a post' do
    visit '/posts'
    click_link 'Comment'
    fill_in "Views", with: "blah blah"
    click_button 'Leave Comment'

    expect(current_path).to eq '/posts'
    expect(page).to have_content('blah blah')
  end
end
