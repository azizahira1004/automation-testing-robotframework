*** Variables ***
${MOBILE_FOOTER_COPYRIGHT}        xpath=//android.widget.TextView[contains(@text,"Sauce Labs. All Rights Reserved.")]
${MOBILE_FOOTER_TERMS}             xpath=//android.widget.TextView[@text="Terms of Service | Privacy Policy"]

*** Keywords ***
Scroll To Mobile Footer
    Scroll Element Into View    ${MOBILE_FOOTER_TERMS}    max_swipes=8

Verify Mobile Footer Legal Text
    Wait Until Element Is Visible    ${MOBILE_FOOTER_COPYRIGHT}    timeout=${MEDIUM_TIMEOUT}
    Wait Until Element Is Visible    ${MOBILE_FOOTER_TERMS}    timeout=${MEDIUM_TIMEOUT}
    ${copyright_text}=    Get Text    ${MOBILE_FOOTER_COPYRIGHT}
    ${terms_text}=    Get Text    ${MOBILE_FOOTER_TERMS}
    Should Contain    ${copyright_text}    Sauce Labs. All Rights Reserved.
    Should Be Equal    ${terms_text}    Terms of Service | Privacy Policy

Verify Mobile Social Media Icons
    ${twitter_glyph}=    Evaluate    chr(0xf099)
    ${facebook_glyph}=    Evaluate    chr(0xf09a)
    ${google_plus_glyph}=    Evaluate    chr(0xf0d5)
    ${linkedin_glyph}=    Evaluate    chr(0xf0e1)
    ${twitter_locator}=    Set Variable    xpath=//android.widget.TextView[@text="${twitter_glyph}"]
    ${facebook_locator}=    Set Variable    xpath=//android.widget.TextView[@text="${facebook_glyph}"]
    ${google_plus_locator}=    Set Variable    xpath=//android.widget.TextView[@text="${google_plus_glyph}"]
    ${linkedin_locator}=    Set Variable    xpath=//android.widget.TextView[@text="${linkedin_glyph}"]
    Wait Until Element Is Visible    ${twitter_locator}    timeout=${MEDIUM_TIMEOUT}
    Wait Until Element Is Visible    ${facebook_locator}    timeout=${MEDIUM_TIMEOUT}
    Wait Until Element Is Visible    ${google_plus_locator}    timeout=${MEDIUM_TIMEOUT}
    Wait Until Element Is Visible    ${linkedin_locator}    timeout=${MEDIUM_TIMEOUT}
