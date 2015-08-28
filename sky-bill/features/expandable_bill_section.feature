Feature: Expandable bill section
  
  A customers bill is made up of packages, calls and sky store purchases (sections), which can each
  contain multiple entries. To keep the interface simple we only display the sections headline and 
  the total cost. A customer can click on a section header and the breakdown will be displayed.

  Scenario: Expand packages
    Given we are logged in
    And we will be on the bill page
    And the 'packages' section content is hidden
    When we click the 'packages' section
    Then the 'packages' section content is shown

  Scenario: Expand calls
    Given we are logged in
    And we will be on the bill page
    And the 'calls' section content is hidden
    When we click the 'calls' section
    Then the 'calls' section content is shown

  Scenario: Expand sky store
    Given we are logged in
    And we will be on the bill page
    And the 'sky store' section content is hidden
    When we click the 'sky store' section
    Then the 'sky store' section content is shown