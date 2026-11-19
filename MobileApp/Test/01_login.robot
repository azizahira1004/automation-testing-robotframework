*** Settings ***
Resource          ../resource.robot
Suite Setup       setup.Spawn Appium Server
Suite Teardown    teardown.Close Appium Server
Test Setup        setup.Open App
Test Teardown     Close Application

*** Test Cases ***
TC01 - Login With Valid Credentials
    [Documentation]    Verifies that standard_user can log in and reach the Products screen.
    LoginLogic.Verify Login Page Element
    LoginLogic.Login With Valid Data
    LoginLogic.Verify Success Login

TC02 - Login Rejects Invalid Credentials
    [Documentation]    Verifies that login is rejected when both the username and password are invalid.
    LoginLogic.Verify Login Page Element
    LoginLogic.Login With Invalid Data
    LoginLogic.Verify Failed Login Message

TC03 - Login Rejects Locked Out User
    [Documentation]    Verifies that login is rejected for a locked-out user.
    LoginLogic.Verify Login Page Element
    LoginLogic.Login With Invalid Data       ${LOCKED_USERNAME}    ${VALID_PASSWORD}
    LoginLogic.Verify Failed Login Message    Sorry, this user has been locked out.

TC04 - Login Rejects Missing Username
    [Documentation]    Verifies that login is rejected when the username is missing.
    LoginLogic.Verify Login Page Element
    LoginLogic.Login With Invalid Data    ${EMPTY}    ${VALID_PASSWORD}
    LoginLogic.Verify Failed Login Message    Username is required