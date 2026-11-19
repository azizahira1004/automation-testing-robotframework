*** Keywords ***
Verify Products Page Is Visible
    Wait Until Element Is Visible       accessibility_id=test-PRODUCTS          timeout=${MEDIUM_TIMEOUT}

Verify Homepage Title
    [Arguments]             ${homepageTitle}
    Wait Until Element Is Visible       xpath=//android.widget.TextView[@text="${homepageTitle}"]    timeout=${MEDIUM_TIMEOUT}
