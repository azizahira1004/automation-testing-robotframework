*** Keywords ***
Verify Mobile Menu Items And All Items Navigation
    BurgerMenuPages.Open Mobile Burger Menu
    BurgerMenuPages.Verify All Mobile Menu Items Are Visible
    BurgerMenuPages.Close Mobile Burger Menu
    BurgerMenuPages.Open Mobile Burger Menu
    BurgerMenuPages.Select Mobile Menu Item    ALL ITEMS
    HomepageLogic.Verify On Homepage

Verify Mobile About Menu Launches External Page
    ${initial_activity}=    Get Activity
    BurgerMenuPages.Open Mobile Burger Menu
    BurgerMenuPages.Select Mobile Menu Item    ABOUT
    Wait Until Keyword Succeeds    15s    1s    BurgerMenuPages.Verify External Activity Differs From    ${initial_activity}

Verify Mobile WebView Rejects Invalid URL
    BurgerMenuPages.Open Mobile Burger Menu
    BurgerMenuPages.Select Mobile Menu Item    WEBVIEW
    BurgerMenuPages.Verify WebView Selection Is Visible
    BurgerMenuPages.Submit WebView URL    not-a-valid-https-url
    BurgerMenuPages.Verify WebView URL Error    Please provide a correct https url

Verify Mobile QR Scanner Menu
    BurgerMenuPages.Open Mobile Burger Menu
    BurgerMenuPages.Select Mobile Menu Item    QR CODE SCANNER
    BurgerMenuPages.Allow Camera Permission If Prompted
    BurgerMenuPages.Verify QR Scanner Is Visible

Verify Mobile Logout Clears Session
    @{items}=    Select Fixed Mobile Checkout Product
    Add Random Mobile Items To Cart    selected_items=${items}
    BurgerMenuPages.Open Mobile Burger Menu
    BurgerMenuPages.Select Mobile Menu Item    LOGOUT
    LoginLogic.Verify Login Page Element
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    ${cart_count}=    Get Cart Badge Count
    Should Be Equal As Integers    ${cart_count}    0

Add Fixed Product To Cart And Verify Badge
    @{items}=    Select Fixed Mobile Checkout Product
    Add Random Mobile Items To Cart    selected_items=${items}
    ${cart_count}=    Get Cart Badge Count
    Should Be Equal As Integers    ${cart_count}    1

Reset Cart From Burger Menu
    BurgerMenuPages.Open Mobile Burger Menu
    BurgerMenuPages.Select Mobile Menu Item    RESET APP STATE

Verify Cart Badge Is Empty
    ${cart_count}=    Get Cart Badge Count
    Should Be Equal As Integers    ${cart_count}    0

Verify Fixed Product Remove Button Is Not Visible
    @{items}=    Select Fixed Mobile Checkout Product
    ${item}=    Set Variable    ${items}[0]
    ProductAndCartPages.Verify Product Remove Button Is Not Visible    ${item}
