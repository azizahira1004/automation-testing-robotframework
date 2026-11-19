*** Variables ***
${BURGER_MENU_BUTTON}             accessibility_id=test-Menu
${BURGER_MENU_CLOSE_BUTTON}       accessibility_id=test-Close
${MENU_ALL_ITEMS}                 accessibility_id=test-ALL ITEMS
${MENU_WEBVIEW}                   accessibility_id=test-WEBVIEW
${MENU_QR_CODE_SCANNER}           accessibility_id=test-QR CODE SCANNER
${MENU_ABOUT}                     accessibility_id=test-ABOUT
${MENU_LOGOUT}                    accessibility_id=test-LOGOUT
${MENU_RESET_APP_STATE}           accessibility_id=test-RESET APP STATE
${WEBVIEW_SELECTION_SCREEN}       accessibility_id=test-WEBVIEW SELECTION
${WEBVIEW_URL_INPUT}              xpath=//android.widget.EditText
${WEBVIEW_GO_BUTTON}              accessibility_id=test-GO TO SITE
${WEBVIEW_ERROR_MESSAGE}          xpath=//android.view.ViewGroup[@content-desc="test-Error message"]//android.widget.TextView
${CAMERA_PERMISSION_ONLY_THIS_TIME}    xpath=//*[@text="Only this time"]
${QR_SCANNER_INSTRUCTIONS}        xpath=//android.widget.TextView[@text="Scan a QR Code that contains a url."]

*** Keywords ***
Open Mobile Burger Menu
    Wait Until Element Is Visible    ${BURGER_MENU_BUTTON}    timeout=${MEDIUM_TIMEOUT}
    Click Element    ${BURGER_MENU_BUTTON}
    Wait Until Element Is Visible    ${MENU_LOGOUT}    timeout=${MEDIUM_TIMEOUT}

Verify All Mobile Menu Items Are Visible
    Wait Until Element Is Visible    ${MENU_ALL_ITEMS}    timeout=${MEDIUM_TIMEOUT}
    Wait Until Element Is Visible    ${MENU_WEBVIEW}    timeout=${MEDIUM_TIMEOUT}
    Wait Until Element Is Visible    ${MENU_QR_CODE_SCANNER}    timeout=${MEDIUM_TIMEOUT}
    Wait Until Element Is Visible    ${MENU_ABOUT}    timeout=${MEDIUM_TIMEOUT}
    Wait Until Element Is Visible    ${MENU_LOGOUT}    timeout=${MEDIUM_TIMEOUT}
    Wait Until Element Is Visible    ${MENU_RESET_APP_STATE}    timeout=${MEDIUM_TIMEOUT}
    Wait Until Element Is Visible    ${BURGER_MENU_CLOSE_BUTTON}    timeout=${MEDIUM_TIMEOUT}

Close Mobile Burger Menu
    Click Element    ${BURGER_MENU_CLOSE_BUTTON}
    ${logout_visible}=    Run Keyword And Return Status    Expect Element    ${MENU_LOGOUT}    visible    timeout=100ms    retry_interval=100ms
    Should Be Equal    ${logout_visible}    ${FALSE}

Select Mobile Menu Item
    [Arguments]    ${menu_item}
    ${locator}=    Set Variable    accessibility_id=test-${menu_item}
    Wait Until Element Is Visible    ${locator}    timeout=${MEDIUM_TIMEOUT}
    Click Element    ${locator}

Verify WebView Selection Is Visible
    Wait Until Element Is Visible    ${WEBVIEW_SELECTION_SCREEN}    timeout=${MEDIUM_TIMEOUT}

Submit WebView URL
    [Arguments]    ${url}
    Input Text    ${WEBVIEW_URL_INPUT}    ${url}
    Click Element    ${WEBVIEW_GO_BUTTON}

Verify WebView URL Error
    [Arguments]    ${expected_error}
    Wait Until Element Is Visible    ${WEBVIEW_ERROR_MESSAGE}    timeout=${MEDIUM_TIMEOUT}
    Element Text Should Be    ${WEBVIEW_ERROR_MESSAGE}    ${expected_error}

Verify QR Scanner Is Visible
    Wait Until Element Is Visible    ${QR_SCANNER_INSTRUCTIONS}    timeout=${LONG_TIMEOUT}

Allow Camera Permission If Prompted
    ${permission_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CAMERA_PERMISSION_ONLY_THIS_TIME}    timeout=2s
    IF    ${permission_visible}
        Click Element    ${CAMERA_PERMISSION_ONLY_THIS_TIME}
        Log    Camera permission prompt detected; selected Only this time.
    ELSE
        Log    Camera permission prompt not present; continuing to verify QR scanner.
    END

Verify External Activity Differs From
    [Arguments]    ${initial_activity}
    ${current_activity}=    Get Activity
    Should Not Be Equal As Strings    ${current_activity}    ${initial_activity}


