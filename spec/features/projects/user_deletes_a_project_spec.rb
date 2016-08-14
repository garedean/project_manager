require 'rails_helper'

Capybara.javascript_driver = :webkit
Capybara.current_driver = :webkit

RSpec.feature 'User deletes a project' do
  scenario 'the project no longer shows on the Projects page', :js => true do
    visit root_path
    click_link 'New Project'

    fill_in "project_title", with: 'The Big Lebowski 2'
    find("#new_project input[type='submit']").click

    click_link 'Projects'

    page.accept_confirm { click_link 'Destroy' }

    expect(page).to have_content 'Project was successfully destroyed.'

    page.evaluate_script("window.location.reload()")

    expect(page).to_not have_content 'The Big Lebowski 2'
  end
end
