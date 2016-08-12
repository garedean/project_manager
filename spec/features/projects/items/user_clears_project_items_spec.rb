feature 'User clears project items' do
  before do
    project = Project.create(title: 'The Big Lebowski 2')
    project.items.create(action: "Call Steve Buscemi's agent")
  end

  scenario 'clearing items recently cleared shows correct flash' do
    visit project_path(1)

    find(".not-done [type='submit']").click

    click_link 'Clear Completed Items'
    expect(page).to have_content 'Completed items were successfully cleared.'
  end

  scenario 'attempting to clear with empty clear-queue shows correct flash' do
    visit project_path(1)

    click_link 'Clear Completed Items'
    expect(page).to have_content 'There are no completed items for '\
                                 'this project.'
  end
end
