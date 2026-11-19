*** Keywords ***
Login With Credentials
    [Arguments]    ${username}    ${password}
    login.Enter Username    ${username}
    login.Enter Password    ${password}
    login.Click Login

Verify Auth Error Message
    [Arguments]    ${expected_error}
    login.Verify Login Error Message    ${expected_error}

Open Browser And Login As Standard User
    TestSetup.Open Homepage
    Login With Credentials    ${STANDARD_USER.USERNAME}    ${STANDARD_USER.PASSWORD}
