# Feature: Cohorts matrix
#   As a gnome
#   I want to collect underpants
#   So I can profit
feature 'Cohorts Matrix' do
  include_context 'four users with thirteen orders'

  # Scenario: Visit the Cohorts page
  #   Given there is data about users and orders in the database
  #   When I visit the page
  #   Then I should see a breakdown into cohorts
  scenario 'visit the cohorts page' do
    visit cohorts_show_path
    expect(page).to have_content 'Quiply Cohorts'
    expect(page).to have_css 'table'
    expect(page).to have_table
    expect(page).to have_css 'table tbody tr', count: 2 # count of cohort joining weeks
    expect(page).to have_css 'table tbody tr td', count: 12 # purchase weeks & join weeks
    # save_and_open_page
  end
end
