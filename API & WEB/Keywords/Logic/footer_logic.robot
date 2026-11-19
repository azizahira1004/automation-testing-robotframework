*** Keywords ***
Verify All Social Media Links In Footer
    Scroll Element Into View    ${FOOTER_CONTAINER}
    Wait Until Element Is Visible    ${FOOTER_CONTAINER}    timeout=5s
    FOR    ${platform}    ${expected_slug}    IN    &{SOCIAL_LINKS}
        ${link_locator}=    footer_page.Get Social Link Locator    ${platform}
        Wait Until Element Is Visible    ${link_locator}    timeout=5s
        Click Element    ${link_locator}
        Switch Window    NEW    timeout=10s
        Wait Until Keyword Succeeds    10s    1s    Verify URL Is Loaded
        ${current_url}=    Get Location
        Verify Social Media URL    ${platform}    ${current_url}    ${expected_slug}
        Verify Page Is Not Blank Or Error
        Close Window
        Switch Window    MAIN
    END

Verify URL Is Loaded
    ${url}=    Get Location
    Should Not Be Equal    ${url}    about:blank
    Should Start With    ${url}    http

Verify Social Media URL
    [Arguments]    ${platform}    ${current_url}    ${expected_slug}
    ${url_lower}=    Convert To Lower Case    ${current_url}
    IF    '${platform}' == 'X'
        Should Contain    ${url_lower}    x.com/
    ELSE IF    '${platform}' == 'Facebook'
        Should Contain    ${url_lower}    facebook.com/
    ELSE IF    '${platform}' == 'LinkedIn'
        Should Contain    ${url_lower}    linkedin.com/
    END
    Should Contain    ${url_lower}    ${expected_slug}
    ...    msg=The ${platform} URL (${current_url}) does not contain '${expected_slug}'.

Verify Page Is Not Blank Or Error
    Wait Until Element Is Visible    tag=body    timeout=10s
    ${page_title}=    Get Title
    ${body_text_length}=    Execute Javascript    return document.body ? document.body.innerText.trim().length : 0;
    Should Be True    ${body_text_length} > 0
    ...    msg=The page body is blank at ${page_title}.
    ${source_length}=    Execute Javascript    return document.documentElement ? document.documentElement.outerHTML.length : 0;
    Should Be True    ${source_length} > 100
    ...    msg=The page appears blank (HTML length: ${source_length} characters).
    Should Not Match Regexp    ${page_title}    (?i)\\b(404|500|502|503|504)\\b
    ...    msg=An HTTP error page was detected at ${page_title}.
