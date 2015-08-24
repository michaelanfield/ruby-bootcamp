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
