Feature: Login to view your bill
  
  The customer bill is in a secure area and requires a valid username and
  password to be viewed. Any attempt to access a bill without authentication
  will result in the customer getting redirected to the login page.

  Scenario: Login with valid credentials
    Given we are on the login page
    And we supply a username of me@you.com
    And we supply a password of p455w0rd
    When we click the Login button
    Then we will be on the bill page

  Scenario Outline: Login with invalid credentials
    Given we are on the login page
    And we supply a username of <username>
    And we supply a password of <password>
    When we click the Login button
    Then we will be on the login page

    Examples:
      | username      | password  |
      | me@you.com    | incorrect |
      | no@access.com | p455w0rd  |
      | no@access.com | incorrect |

  Scenario: Access to bill directly should redirect to login
    Given we are not logged in
    When we navigate to the bill page
    Then we will be on the login page

  Scenario: Once logged in you should be able to logout
    Given we are logged in
    When we click the Logout button
    Then we will be on the login page