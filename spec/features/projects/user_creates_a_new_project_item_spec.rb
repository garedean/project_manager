feature 'User creates a new project item' do
  before do
    Project.create(title: 'The Big Lebowski 2')
  end

  scenario 'they see new item listed under project' do
    visit project_path(1)

    click_link 'New Item'
    fill_in 'item_action', with: "Call Steve Buscemi's agent"
    find(".new_item input[type='submit']").click

    expect(page).to have_content 'The Big Lebowski 2 Items'
    expect(page).to have_content "Call Steve Buscemi's agent"
  end
end
