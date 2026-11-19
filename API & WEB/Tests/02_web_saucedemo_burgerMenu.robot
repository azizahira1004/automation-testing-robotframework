*** Settings ***
Resource          ${EXECDIR}/resources.txt
Test Setup        Open Browser And Login As Standard User
Test Teardown     Capture Failed and Close All Browsers
Suite Teardown    Close All Browsers

*** Test Cases ***
TC01 - Verify Dynamic Catalog Lazy Load, Spinner And Slider
    [Documentation]    Verify Dynamic Catalog submenus (Lazy Load, Spinner, Slider) work according to expected behavior
    [Tags]    burger_menu    dynamic_catalog
    Verify Lazy Load Behavior
    Verify Spinner Catalog Behavior
    Verify Slider Behavior

TC02 - Verify About Menu Navigates To Valid SauceLabs Page
    [Documentation]    Verify clicking About redirects to https://saucelabs.com/ without blank screen, 404, or 5xx errors
    [Tags]    burger_menu    about
    burger_menu_page.Open Burger Menu
    burger_menu_logic.Click About Menu And Verify SauceLabs Page

TC03 - Verify Logout Menu Redirects Back To Login Page
    [Documentation]    Verify clicking Logout terminates session and returns user to login page
    [Tags]    burger_menu    logout
    burger_menu_page.Open Burger Menu
    burger_menu_logic.Click Logout Menu And Verify Redirect To Login

TC04 - Verify Reset App State Clears Cart Badge And Documents Button State Bug
    [Documentation]    Verify Reset App State removes cart badge count (3 -> empty) while product buttons remain 'Remove'
    [Tags]    burger_menu    reset_app_state    known_bug
    burger_menu_logic.Add Multiple Products To Cart    3
    inventory_page.Verify Cart Badge Count    3
    burger_menu_page.Open Burger Menu
    burger_menu_logic.Click Reset App State
    burger_menu_logic.Verify Reset App State Clears Badge But Keeps Remove Buttons    3