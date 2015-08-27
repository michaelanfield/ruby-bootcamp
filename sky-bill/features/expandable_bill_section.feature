Feature: Expandable bill section
  
  A customers bill is made up of packages, calls and sky store purchases (sections), which can each
  contain multiple entries. To keep the interface simple we only display the sections headline and 
  the total cost. A customer can click on a section header and the breakdown will be displayed.

  Scenario: Expand packages
    Given we are logged in
    And we will be on the bill page
    When we click the packages section
    Then we will see 'Variety with Movies HD' at a cost of £50.00
    And we will see 'Sky Talk Anytime' at a cost of £5.00
    And we will see 'Fibre Unlimited' at a cost of £16.40

  Scenario: Expand calls
    Given we are logged in
    And we will be on the bill page
    When we click the call_charges section
    Then we will see 07716393769 for a duration of 00:23:03 at a cost of £2.13
    And we will see 02074351359 for a duration of 00:23:03 at a cost of £2.13

  Scenario: Expand sky store
    Given we are logged in
    And we will be on the bill page
    When we click the sky_store section
    Then we will see a 'rentals' group with 1 item
    And we will see a 'buy and keep' group with 2 items 