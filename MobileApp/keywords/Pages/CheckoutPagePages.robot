*** Variables ***
${DEFAULT_TIMEOUT}              10s
${LONG_TIMEOUT}                 15s

# Login Screen
${INPUT_USERNAME}               accessibility_id=test-Username
${INPUT_PASSWORD}               accessibility_id=test-Password
${BTN_LOGIN}                    accessibility_id=test-LOGIN

# Inventory / Products Screen
${INVENTORY_CONTAINER}          xpath=//*[@content-desc="test-Products" or @content-desc="test-PRODUCTS" or @text="PRODUCTS"]
${LBL_CART_BADGE}               xpath=//android.view.ViewGroup[@content-desc="test-Cart"]//android.widget.TextView
${BTN_CART}                     accessibility_id=test-Cart
${ALL_ADD_TO_CART_BTNS}         xpath=//*[@content-desc="test-ADD TO CART"]
${ALL_REMOVE_BTNS}              xpath=//*[@content-desc="test-REMOVE"]
${ALL_ITEM_TITLES}              xpath=//android.widget.TextView[@content-desc="test-Item title"]
${CART_CONTENT_SCREEN}          accessibility_id=test-Cart Content

# Cart Screen
${BTN_CHECKOUT}                 accessibility_id=test-CHECKOUT

# Checkout: Information Screen
${INPUT_FIRST_NAME}             accessibility_id=test-First Name
${INPUT_LAST_NAME}              accessibility_id=test-Last Name
${INPUT_POSTAL_CODE}            accessibility_id=test-Zip/Postal Code
${BTN_CONTINUE}                 accessibility_id=test-CONTINUE
${BTN_CANCEL_CHECKOUT}          accessibility_id=test-CANCEL
${LBL_ERROR_MSG}                xpath=//android.view.ViewGroup[@content-desc="test-Error message"]//android.widget.TextView
${LBL_ITEM_TOTAL}               xpath=//android.widget.TextView[contains(@text,"Item total")]
${LBL_TAX}                      xpath=//android.widget.TextView[contains(@text,"Tax")]
${LBL_TOTAL}                    xpath=//android.widget.TextView[contains(@text,"Total:")]

# Checkout: Overview & Complete Screen
${BTN_FINISH}                   accessibility_id=test-FINISH
${BTN_BACK_HOME}                accessibility_id=test-BACK HOME
${LBL_COMPLETE_TEXT}            xpath=//android.widget.ScrollView//android.widget.TextView[contains(@text,"THANK YOU") or contains(@text,"Thank you")]

*** Keywords ***
Scroll Down Safe
    [Arguments]    ${duration}=1s
    Swipe By Percent    50    70    50    30    ${duration}

Scroll Up Safe
    [Arguments]    ${duration}=1s
    Swipe By Percent    50    30    50    70    ${duration}

Scroll To Top Safe
    [Arguments]    ${max_swipes}=5
    FOR    ${i}    IN RANGE    ${max_swipes}
        ${is_cart}=    Run Keyword And Return Status    Expect Element    ${BTN_CART}    visible    timeout=100ms    retry_interval=100ms
        IF    ${is_cart}
            RETURN
        END
        Scroll Up Safe    1s
    END

Scroll Element Into View
    [Arguments]    ${locator}    ${max_swipes}=6
    FOR    ${i}    IN RANGE    ${max_swipes}
        ${visible}=    Run Keyword And Return Status    Expect Element    ${locator}    visible    timeout=100ms    retry_interval=100ms
        IF    ${visible}
            RETURN
        END
        Scroll Down Safe    600ms
    END
    Wait Until Element Is Visible    ${locator}    timeout=${DEFAULT_TIMEOUT}

Input Login Credentials
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible       ${INPUT_USERNAME}    timeout=${DEFAULT_TIMEOUT}
    Clear Text                          ${INPUT_USERNAME}
    Input Text                          ${INPUT_USERNAME}     ${username}
    Clear Text                          ${INPUT_PASSWORD}
    Input Text                          ${INPUT_PASSWORD}     ${password}
    Run Keyword And Ignore Error        Hide Keyboard
    Wait Until Element Is Visible       ${BTN_LOGIN}         timeout=${DEFAULT_TIMEOUT}
    Click Element                       ${BTN_LOGIN}

Wait For Products Screen
    [Arguments]    ${timeout}=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${INVENTORY_CONTAINER}    timeout=${timeout}

Get Cart Badge Count
    ${has_badge}=    Run Keyword And Return Status    Expect Element    ${LBL_CART_BADGE}    visible    timeout=100ms    retry_interval=100ms
    IF    not ${has_badge}
        RETURN    ${0}
    END
    ${badge_text}=    Get Text    ${LBL_CART_BADGE}
    ${count}=         Convert To Integer    ${badge_text}
    RETURN    ${count}

Open Mobile Cart
    Scroll To Top Safe    5
    Wait Until Element Is Visible    ${BTN_CART}    timeout=${DEFAULT_TIMEOUT}
    Click Element                   ${BTN_CART}
    Wait Until Element Is Visible    ${CART_CONTENT_SCREEN}    timeout=${DEFAULT_TIMEOUT}

Proceed Mobile Checkout
    Scroll Element Into View    ${BTN_CHECKOUT}    max_swipes=4
    Click Element               ${BTN_CHECKOUT}
    Wait Until Element Is Visible    ${INPUT_FIRST_NAME}    timeout=${DEFAULT_TIMEOUT}

Fill Mobile Shipping Information
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Wait Until Element Is Visible    ${INPUT_FIRST_NAME}    timeout=${DEFAULT_TIMEOUT}
    Clear Text                      ${INPUT_FIRST_NAME}
    Clear Text                      ${INPUT_LAST_NAME}
    Clear Text                      ${INPUT_POSTAL_CODE}
    Input Text                      ${INPUT_FIRST_NAME}     ${first_name}
    Input Text                      ${INPUT_LAST_NAME}      ${last_name}
    Input Text                      ${INPUT_POSTAL_CODE}    ${postal_code}
    Click Element                   ${BTN_CONTINUE}

Cancel Mobile Checkout Information
    Wait Until Element Is Visible    ${BTN_CANCEL_CHECKOUT}    timeout=${DEFAULT_TIMEOUT}
    Click Element                   ${BTN_CANCEL_CHECKOUT}
    Wait Until Element Is Visible    ${INVENTORY_CONTAINER}    timeout=${DEFAULT_TIMEOUT}

Get Mobile Checkout Error Text
    Wait Until Element Is Visible    ${LBL_ERROR_MSG}    timeout=${DEFAULT_TIMEOUT}
    ${msg}=    Get Text    ${LBL_ERROR_MSG}
    RETURN    ${msg}

Complete Mobile Order
    Scroll Element Into View    ${BTN_FINISH}    max_swipes=6
    Click Element               ${BTN_FINISH}

Verify Checkout Overview Screen
    Scroll Element Into View    ${LBL_ITEM_TOTAL}    max_swipes=6
    Wait Until Element Is Visible    ${LBL_ITEM_TOTAL}    timeout=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${LBL_TAX}    timeout=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${LBL_TOTAL}    timeout=${DEFAULT_TIMEOUT}
    Scroll Element Into View    ${BTN_FINISH}    max_swipes=6
    Wait Until Element Is Visible    ${BTN_FINISH}    timeout=${DEFAULT_TIMEOUT}

Verify Mobile Order Confirmation
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${LBL_COMPLETE_TEXT}    timeout=${DEFAULT_TIMEOUT}
    ${actual_text}=    Get Text    ${LBL_COMPLETE_TEXT}
    Should Contain    ${actual_text}    ${expected_text}    ignore_case=True

Click Back Home After Complete
    Wait Until Element Is Visible    ${BTN_BACK_HOME}    timeout=${DEFAULT_TIMEOUT}
    Click Element    ${BTN_BACK_HOME}
    Wait Until Element Is Visible    ${INVENTORY_CONTAINER}    timeout=${DEFAULT_TIMEOUT}