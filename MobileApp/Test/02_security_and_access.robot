*** Settings ***
Documentation     Tests access control and special-user behavior in the Swag Labs mobile app.
Resource          ../resource.robot
Suite Setup       setup.Spawn Appium Server
Test Setup        setup.Open App
Test Teardown     teardown.Terminate Mobile App And Close Session
Suite Teardown    teardown.Close Appium Server

*** Test Cases ***
TC01 - Access Control: Catalog And Cart Are Unavailable Before Login
    [Tags]    security    negative
    [Documentation]    Verifies that unauthenticated users cannot access the catalog or cart controls from the login screen. The native app has no direct cart URL.
    LoginLogic.Verify Login Page Element
    ${cart_visible}=    Run Keyword And Return Status    Expect Element    ${BTN_CART}    visible    timeout=100ms    retry_interval=100ms
    Should Be Equal    ${cart_visible}    ${FALSE}
    ${products_visible}=    Run Keyword And Return Status    Expect Element    ${INVENTORY_CONTAINER}    visible    timeout=100ms    retry_interval=100ms
    Should Be Equal    ${products_visible}    ${FALSE}

TC02 - Defect Detection: Product Buttons On Problem User
    [Tags]    security    problem_user    defect_detection
    [Documentation]    Detects Add/Remove button transition defects for problem_user and reports broken transitions without failing the test.
    Login Mobile User And Verify Catalog    problem_user    secret_sauce
    @{selected_items}=    Select Fixed Mobile Checkout Product
    Verify Mobile Selected Buttons Functionality    ${selected_items}    allow_broken=${TRUE}
