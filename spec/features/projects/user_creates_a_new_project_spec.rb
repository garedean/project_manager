require 'rails_helper'

RSpec.feature 'User creates a new project' do
  scenario 'they cannot add the same project twice' do
    visit root_path
    click_link 'New Project'

    fill_in "project_title", with: 'The Big Lebowski 2'
    find("#new_project input[type='submit']").click

    click_link 'Projects'
    click_link 'New Project'

    fill_in 'project_title', with: 'The Big Lebowski 2'
    find("#new_project input[type='submit']").click

    expect(page).to have_content 'has already been taken'
  end
end
