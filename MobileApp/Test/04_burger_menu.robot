*** Settings ***
Documentation     Tests navigation and burger menu behavior in the Swag Labs mobile app.
Resource          ../resource.robot
Suite Setup       setup.Spawn Appium Server
Test Setup        setup.Open App
Test Teardown     Close Application
Suite Teardown    teardown.Close Appium Server

*** Test Cases ***
TC01 - Verify Mobile Menu Items And All Items Navigation
    [Tags]    burger_menu    navigation
    [Documentation]    Verifies that all burger menu items are visible and that All Items returns to the product inventory.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    BurgerMenuLogic.Verify Mobile Menu Items And All Items Navigation

TC02 - Verify About Menu Launches External Activity
    [Tags]    burger_menu    about
    [Documentation]    Verifies that selecting About launches an external activity.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    BurgerMenuLogic.Verify Mobile About Menu Launches External Page

TC03 - WebView Menu Rejects Invalid URL
    [Tags]    burger_menu    webview    negative
    [Documentation]    Verifies that the WebView rejects a malformed URL with the expected validation error.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    BurgerMenuLogic.Verify Mobile WebView Rejects Invalid URL

TC04 - QR Code Scanner Menu Opens Scanner
    [Tags]    burger_menu    qr_scanner
    [Documentation]    Verifies that the QR scanner opens and handles the camera permission prompt only when it appears.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    BurgerMenuLogic.Verify Mobile QR Scanner Menu

TC05 - Logout Menu Clears Session
    [Tags]    burger_menu    logout
    [Documentation]    Verifies that logout clears the active session and cart state before the next login.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    BurgerMenuLogic.Verify Mobile Logout Clears Session

TC06 - Reset App State Clears Cart Badge
    [Tags]    burger_menu    reset_app_state
    [Documentation]    Verifies that Reset App State clears the cart badge and restores the product's Add to Cart button.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    BurgerMenuLogic.Add Fixed Product To Cart And Verify Badge
    BurgerMenuLogic.Reset Cart From Burger Menu
    BurgerMenuLogic.Verify Cart Badge Is Empty
    BurgerMenuLogic.Verify Fixed Product Remove Button Is Not Visible
