Feature: Issue List
  As a User,
  I should be able to see a list of issues,
  so I can read Pivotal articles

  Scenario: User looks at the list of issues on an iphone
    Given I reset the simulator
    And I launch the app on the iphone

    Then I should see "Pivotal Culture"
    And I should see "Getting started on the right foot"

  Scenario: User looks at the list of issues on an ipad
    Given I reset the simulator
    And I launch the app on the ipad

    Then I should see "Pivotal Culture"
    Then I should see "Getting started on the right foot"

  Scenario: User looks at the list of issues on an ipad in portrait mode
    Given I reset the simulator
    And I launch the app on the ipad
    And the device is in portrait orientation

    When I touch "Issues"
    Then I should see the issues popover
    And I should see "Pivotal Culture" in issues popover
    And I should see "Getting started on the right foot" in issues popover
    
  Scenario: User launches the app, closes the app, relaunches the app
    Given I reset the simulator
    And I launch the app on the iphone
    Then I should see "Pivotal Culture"
    
    When I quit the simulator
    And I launch the app on the iphone
    Then I should see "Pivotal Culture"

    When I select the first issue
    Then I should see that the issue becomes available
