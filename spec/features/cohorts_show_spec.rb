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
    expect(page).to have_css 'table thead tr', count: 1 # count of cohort joining weeks
    expect(page).to have_css 'table thead tr th', count: 6 # count of cohort joining weeks
    expect(page).to have_css 'table tbody tr', count: 2 # count of cohort joining weeks
    expect(page).to have_css 'table tbody tr td', count: 12 # purchase weeks & join weeks

    expect_table(<<~EOTABLE)
      | Cohort     | Users   | 0-7 days                            | 7-14 days                         | 14-21 days                        | 21-28 days                       |
      | 11/2-11/9  | 3 users | 33% orderers (1) 33% 1st Time (1)   | 33% orderers (1) 33% 1st Time (1) | 66% orderers (2) 33% 1st Time (1) | 33% orderers (1) 0% 1st Time (0) |
      | 10/26-11/2 | 1 users | 100% orderers (1) 100% 1st Time (1) | 100% orderers (1) 0% 1st Time (0) | 100% orderers (1) 0% 1st Time (0) |                                  |
    EOTABLE

  end
end
