Feature: Application
  As I user,
  I should be able to open the application,
  so I can read Pivotal Labs content

  Scenario: User opens the application
    Given I launch the app
    Then I should see the home screen
