*** Keywords ***
Open Chrome Browser
    [Timeout]        120 seconds
    [Arguments]      ${url}=about:blank    ${alias}=${EMPTY}
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method      ${chrome_options}    add_argument    --no-sandbox
    Call Method      ${chrome_options}    add_argument    --incognito
    Call Method      ${chrome_options}    add_argument    --guest
    Call Method      ${chrome_options}    add_argument    --disable-save-password-bubble
    Call Method      ${chrome_options}    add_argument    --disable-features\=PasswordLeakDetection,PasswordManagerOnboarding,SafeBrowsingEnhancedProtection
    Call Method      ${chrome_options}    add_argument    --log-level\=3
    Call Method      ${chrome_options}    add_argument    --silent
    Call Method      ${chrome_options}    add_experimental_option    detach    ${True}

    ${prefs}=        Create Dictionary
    ...              credentials_enable_service=${False}
    ...              profile.password_manager_enabled=${False}
    ...              profile.password_manager_leak_detection=${False}
    ...              safebrowsing.enabled=${False}
    Call Method      ${chrome_options}    add_experimental_option    prefs    ${prefs}

    Open Browser     ${url}    chrome    alias=${alias}    options=${chrome_options}
    Set Window Size  1280    960
    Maximize Browser Window
    Set Selenium Speed    0s

Open Homepage
    Open Chrome Browser
    Go To               ${SERVER}