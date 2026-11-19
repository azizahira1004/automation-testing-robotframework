*** Keywords ***
Verify Lazy Load Behavior
    burger_menu_page.Open Burger Menu
    burger_menu_page.Open Dynamic Catalog Dropdown
    Click Element    ${SUBMENU_LAZY_LOAD}
    Wait Until Element Is Visible    ${LAZY_LOAD_CONTAINER}    timeout=10s
    ${initial_count}=    Get Element Count    ${LAZY_LOAD_CARD}
    Should Be True    ${initial_count} > 0    msg=No initial lazy-load cards found.
    Wait Until Keyword Succeeds    10s    500ms    Scroll Sentinel And Verify Item Count Increased    ${initial_count}
    ${after_count}=    Get Element Count    ${LAZY_LOAD_CARD}
    ${added_count}=    Evaluate    ${after_count} - ${initial_count}
    Log    Lazy load completed: ${initial_count} initial cards, ${after_count} after scrolling (+${added_count}).

Scroll Sentinel And Verify Item Count Increased
    [Arguments]    ${initial_count}
    ${sentinel}=    Get WebElement    ${LAZY_LOAD_SENTINEL}
    Execute Javascript    arguments[0].scrollIntoView({behavior: 'instant', block: 'center'});    ARGUMENTS    ${sentinel}
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    ${current_count}=    Get Element Count    ${LAZY_LOAD_CARD}
    Should Be True    ${current_count} > ${initial_count}
    ...    msg=Expected the card count to increase after scrolling (initial: ${initial_count}, current: ${current_count}).

Verify Spinner Catalog Behavior
    [Documentation]    Verifies that the loading spinner completes and all catalog cards render.
    burger_menu_page.Open Burger Menu
    burger_menu_page.Open Dynamic Catalog Dropdown
    Click Element    ${SUBMENU_SPINNER}
    Element Text Should Be    ${SPINNER_TITLE}    Dynamic Catalog - Spinner
    Wait Until Element Is Not Visible    ${LOADING_SPINNER}    timeout=10s
    Wait Until Element Is Visible    ${SPINNER_CONTAINER}    timeout=10s
    Wait Until Element Is Visible    ${SPINNER_GRID}    timeout=10s
    ${item_count}=    Get Element Count    ${SPINNER_CARD}
    Should Be Equal As Integers    ${item_count}    6
    ...    msg=Expected 6 catalog items after loading, but found ${item_count}.
    FOR    ${index}    IN RANGE    ${item_count}
        Element Should Be Visible    css=[data-test="spinner-item-${index}"]
        Element Should Be Visible    css=[data-test="spinner-item-${index}-img"]
        ${name}=    Get Text    css=[data-test="spinner-item-${index}-name"]
        Should Not Be Empty    ${name}
        ${price}=    Get Text    css=[data-test="spinner-item-${index}-price"]
        Should Match Regexp    ${price}    ^\\$\\d+\\.\\d{2}$
    END

Verify Slider Behavior
    burger_menu_page.Open Burger Menu
    burger_menu_page.Open Dynamic Catalog Dropdown
    Click Element    ${SUBMENU_SLIDER}
    Element Text Should Be    ${SLIDER_TITLE}    Dynamic Catalog - Slider
    Wait Until Element Is Visible    ${SLIDER_CONTAINER}    timeout=10s
    Wait Until Element Is Visible    ${SLIDER_ITEM}    timeout=10s
    ${dot_count}=    Get Element Count    ${SLIDER_DOTS}
    Should Be Equal As Integers    ${dot_count}    6
    ...    msg=Expected 6 slider pagination dots, but found ${dot_count}.
    FOR    ${index}    IN RANGE    ${dot_count}
        ${dot_locator}=    Set Variable    css=[data-test="dynamic-catalog-slider-dot-${index}"]
        Click Element    ${dot_locator}
        Element Attribute Value Should Be    ${dot_locator}    aria-current    true
        ${dot_class}=    Get Element Attribute    ${dot_locator}    class
        Should Contain    ${dot_class}    active
        ${aria_label}=    Get Element Attribute    ${dot_locator}    aria-label
        ${displayed_name}=    Get Text    ${SLIDER_ITEM_NAME}
        Should Be Equal    ${aria_label}    Show ${displayed_name}
        ...    msg=Slide mismatch on dot ${index}: expected '${aria_label}', got 'Show ${displayed_name}'.
        Element Should Be Visible    ${SLIDER_ITEM_IMG}
        ${displayed_price}=    Get Text    ${SLIDER_ITEM_PRICE}
        Should Match Regexp    ${displayed_price}    ^\\$\\d+\\.\\d{2}$
        Log    Slider dot ${index}: ${displayed_name} (${displayed_price}).
    END

Click About Menu And Verify SauceLabs Page
    Click Element    ${MENU_ABOUT}
    Wait Until Location Contains    saucelabs.com    15s
    ${current_url}=    Get Location
    Should Contain    ${current_url}    https://saucelabs.com
    ${status_code}=    Execute Javascript
    ...    const nav = performance.getEntriesByType('navigation')[0]; return nav ? nav.responseStatus : 200;
    Should Be True    ${status_code} < 400    msg=Page returned HTTP status ${status_code}.
    Wait Until Element Is Visible    css=body    10s
    ${body_text}=    Get Text    css=body
    Should Not Be Empty    ${body_text}    msg=The SauceLabs page body is blank.
    ${title}=    Get Title
    Should Not Contain    ${title}    404
    Should Not Contain    ${title}    500
    Should Not Contain    ${title}    502
    Should Not Contain    ${title}    503

Click Logout Menu And Verify Redirect To Login
    Click Element    ${MENU_LOGOUT}
    Wait Until Element Is Visible    ${LOGIN_BUTTON}    10s
    ${current_url}=    Get Location
    Should Be Equal    ${current_url}    https://www.saucedemo.com/

Add Multiple Products To Cart
    [Arguments]    ${count}=3
    Wait Until Element Is Visible    ${ADD_TO_CART_BUTTONS}    10s
    @{buttons}=    Get WebElements    ${ADD_TO_CART_BUTTONS}
    FOR    ${index}    IN RANGE    ${count}
        Click Element    ${buttons}[${index}]
    END

Click Reset App State
    burger_menu_page.Click Reset Link

Verify Reset App State Clears Badge But Keeps Remove Buttons
    [Arguments]    ${expected_remove_btn_count}=3
    Wait Until Element Is Not Visible    ${CART_BADGE}    5s
    ${remove_count}=    Get Element Count    ${REMOVE_BUTTONS}
    Should Be Equal As Integers    ${remove_count}    ${expected_remove_btn_count}
    ...    msg=Expected ${expected_remove_btn_count} product buttons to remain in the Remove state due to the known SauceDemo behavior.
