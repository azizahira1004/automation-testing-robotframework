*** Variables ***
${TXT_USERNAME}        id=user-name
${TXT_PASSWORD}        id=password
${BTN_LOGIN}           id=login-button
${MSG_LOGIN_ERROR}     css=[data-test="error"]

*** Keywords ***
Enter Username
    [Arguments]    ${username}
    Input Text       ${TXT_USERNAME}    ${username}

Enter Password
    [Arguments]    ${password}
    Input Password   ${TXT_PASSWORD}    ${password}

Click Login
    Click Button     ${BTN_LOGIN}

Verify Login Error Message
    [Arguments]    ${expected_message}
    Wait Until Element Is Visible    ${MSG_LOGIN_ERROR}    5s
    Element Should Contain           ${MSG_LOGIN_ERROR}    ${expected_message}