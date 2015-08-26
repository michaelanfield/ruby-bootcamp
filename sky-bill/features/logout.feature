Feature: Logout
  
  Once a customer has logged in they should be able to logout.

  Scenario: Logout
    Given we are logged in
    When we click the logout button
    Then we will be on the login page