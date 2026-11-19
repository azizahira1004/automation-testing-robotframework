*** Variables ***
${USERNAME_INPUT}    accessibility_id=test-Username 
${PASSWORD_INPUT}    accessibility_id=test-Password
${LOGIN_BUTTON}      accessibility_id=test-LOGIN

*** Keywords ***
Verify Field Username
    Wait Until Element Is Visible       ${USERNAME_INPUT}          timeout=${LONG_TIMEOUT}

Verify Field Password
    Wait Until Element Is Visible       ${PASSWORD_INPUT}          timeout=${MEDIUM_TIMEOUT}

Verify Login Button
    Wait Until Element Is Visible       ${LOGIN_BUTTON}             timeout=${MEDIUM_TIMEOUT}

Input Username
    [Arguments]             ${username}
    Input Text              ${USERNAME_INPUT}          ${username}

Input Password
    [Arguments]             ${password}
    Input Text              ${PASSWORD_INPUT}          ${password}

Tap Login Button
    Click Element           ${LOGIN_BUTTON}

Verify Error Message
    [Arguments]             ${expectedErrorText}
    Wait Until Element Is Visible       accessibility_id=test-Error message     timeout=${MEDIUM_TIMEOUT}
    Wait Until Element Is Visible       xpath=//android.view.ViewGroup[@content-desc="test-Error message"]//android.widget.TextView[@text="${expectedErrorText}"]    timeout=${FAST_TIMEOUT}
