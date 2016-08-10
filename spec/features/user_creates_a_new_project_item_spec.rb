feature 'User creates a new project item' do
  before do
    Project.create(title: 'The Big Lebowski 2')
  end

  scenario 'they see new item listed under project' do
    visit project_path(1)

    click_link 'New Item'

    expect(page).to have_content 'New Task'
  end
end
