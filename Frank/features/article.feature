Feature: Article
  As a User,
  I should be able to read see a list of articles for each issue,
  so I can read Pivotal articles

  Scenario: User can download a given issue and view an article on an iphone
    Given I reset the simulator
    And I launch the app on the iphone

    When I select the first issue
    And I wait for the download to finish

    When I select the first issue
    Then I should see "Pivotal Labs: Why it works"
    And I should see "Ramping up at Pivotal Labs"
    
    When I select the first article
    Then I should be able to view the issue's contents
    And I should not see "Ramping up at Pivotal Labs"

  Scenario: User can download a given issue and view an article on an ipad
    Given I reset the simulator
    And I launch the app on the ipad
    And the device is in landscape orientation

    When I select the first issue
    And I wait for the download to finish

    When I select the first issue
    Then I select the first article
    Then I should be able to view the issue's contents

  Scenario: User can download and view an article on an ipad in portrait mode
    Given I reset the simulator
    And I launch the app on the ipad
    And the device is in portrait orientation

    When I touch "Issues"
    And I select the first issue
    And I wait for the download to finish

    When I select the first issue
    Then I select the first article
    Then I should be able to view the issue's contents
    And I should not see "Ramping up at Pivotal Labs"
