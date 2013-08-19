Feature: Article List
  As a User,
  I should be able to see a list of articles for each issue,
  so I can read Pivotal articles

  Scenario: User can download a given issue and view its articles on an iphone
    Given I reset the simulator
    And I launch the app on the iphone

    When I select the first issue
    And I wait for the download to finish

    When I select the first issue
    Then I should see "Pivotal Labs: Why it works"
    And I should see "A discussion on the working day at Pivotal Labs and why we don't hire ninjas or rockstars"
    And I should see "Ramping up at Pivotal Labs"

  Scenario: User can download a given issue and view its articles on an ipad
    Given I reset the simulator
    And I launch the app on the ipad
    And the device is in landscape orientation

    When I select the first issue
    And I wait for the download to finish

    When I select the first issue
    Then I should see "Pivotal Labs: Why it works"
    And I should see "A discussion on the working day at Pivotal Labs and why we don't hire ninjas or rockstars"
    And I should see "Ramping up at Pivotal Labs"

  Scenario: User can download and view its articles a given issue on an ipad in portrait mode
    Given I reset the simulator
    And I launch the app on the ipad
    And the device is in portrait orientation

    When I touch "Issues"
    And I select the first issue
    And I wait for the download to finish

    When I select the first issue
    Then I should see "Pivotal Labs: Why it works" in issues popover
    And I should see "A discussion on the working day at Pivotal Labs and why we don't hire ninjas or rockstars"
    And I should see "Ramping up at Pivotal Labs" in issues popover
