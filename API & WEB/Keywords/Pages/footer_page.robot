*** Variables ***
${FOOTER_CONTAINER}       class=footer
&{SOCIAL_LINKS}
...    X=saucelabs
...    Facebook=saucelabs
...    LinkedIn=sauce-labs

*** Keywords ***
Get Social Link Locator
    [Arguments]    ${platform}
    ${locator}=    Set Variable    xpath=//footer//a[contains(@href, '${platform.lower()}.com')]
    RETURN    ${locator}
