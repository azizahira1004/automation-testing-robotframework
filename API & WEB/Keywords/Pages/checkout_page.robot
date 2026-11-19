*** Variables ***
${TXT_FIRST_NAME}      id=first-name
${TXT_LAST_NAME}       id=last-name
${TXT_POSTAL_CODE}     id=postal-code
${BTN_CANCEL}          id=cancel
${BTN_CONTINUE}        id=continue
${BTN_FINISH}          id=finish
${LBL_COMPLETE}        class=complete-header
${MSG_CHECKOUT_ERR}    css=[data-test="error"]

*** Keywords ***
Enter Shipping Information
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    IF    '${first_name}' != '${EMPTY}'
        Input Text    id=first-name    ${first_name}
    END
    IF    '${last_name}' != '${EMPTY}'
        Input Text    id=last-name    ${last_name}
    END
    IF    '${postal_code}' != '${EMPTY}'
        Input Text    id=postal-code    ${postal_code}
    END


Click Continue Button
    Click Button    ${BTN_CONTINUE}

Get Shipping Input Error
    Wait Until Element Is Visible    ${MSG_CHECKOUT_ERR}    5s
    ${error_message}=    Get Text    ${MSG_CHECKOUT_ERR}
    RETURN    ${error_message}

Click Finish Button
    Wait Until Element Is Visible    ${BTN_FINISH}    5s
    Click Button    ${BTN_FINISH}

Click Cancel Button
    Wait Until Element Is Visible    ${BTN_CANCEL}    5s
    Click Button    ${BTN_CANCEL}
