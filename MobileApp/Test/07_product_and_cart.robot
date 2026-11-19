*** Settings ***
Documentation     Tests product inventory, product details, and cart behavior in the Swag Labs mobile app.
Resource          ../resource.robot
Suite Setup       setup.Spawn Appium Server
Test Setup        setup.Open App
Test Teardown     teardown.Terminate Mobile App And Close Session
Suite Teardown    teardown.Close Appium Server

*** Test Cases ***
TC01 - Inventory Page: Add And Remove Product Directly
    [Tags]    inventory    cart    positive    negative
    [Documentation]    Verifies that a product can be added to and removed from the inventory, updating the cart badge and button state.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    ProductAndCartLogic.Add Fixed Product To Cart
    ProductAndCartLogic.Verify Cart Badge Count    1
    ProductAndCartPages.Remove Product From Inventory By Name    Sauce Labs Backpack
    ProductAndCartLogic.Verify Cart Badge Count    0
    ProductAndCartPages.Verify Product Remove Button Is Not Visible    Sauce Labs Backpack

TC02 - Product Detail Page: Verify Info And Add To Cart
    [Tags]    product_detail    positive
    [Documentation]    Verifies the product name, description, and price on the detail page, then adds the product to the cart.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    ${expected_price}=    ProductAndCartPages.Get Inventory Product Price    Sauce Labs Backpack
    ProductAndCartPages.Open Product Detail By Name    Sauce Labs Backpack
    ProductAndCartLogic.Verify Product Detail Information    Sauce Labs Backpack    ${expected_price}
    ProductAndCartPages.Add Product To Cart From Detail
    ProductAndCartLogic.Verify Cart Badge Count    1
    ProductAndCartPages.Back To Products From Detail
    ProductAndCartPages.Verify Product Remove Button Is Visible    Sauce Labs Backpack

TC03 - Cart Page: Remove Item And Continue Shopping
    [Tags]    cart    navigation
    [Documentation]    Verifies that a cart item can be removed and that Continue Shopping returns to inventory with an empty cart.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    ProductAndCartLogic.Add Fixed Product To Cart
    ProductAndCartLogic.Open Product Cart
    ProductAndCartLogic.Verify Product In Cart    Sauce Labs Backpack
    ProductAndCartLogic.Remove Product From Cart    Sauce Labs Backpack
    ProductAndCartLogic.Verify Cart Badge Count    0
    ProductAndCartLogic.Continue Shopping
    HomepageLogic.Verify On Homepage
    ProductAndCartLogic.Verify Cart Badge Count    0

TC04 - Cart Page: Edge Case Checkout With Empty Cart
    [Tags]    cart    edge_case    negative
    [Documentation]    Verifies the empty-cart state and the app's behavior when checkout is started with no items.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    ProductAndCartLogic.Open Product Cart
    ProductAndCartLogic.Verify Cart Is Empty
    ProductAndCartLogic.Checkout From Cart
    ProductAndCartLogic.Verify Checkout Information Screen

TC05 - Cart Page: Other Items Remain After Removing One Product
    [Tags]    cart    edge_case    positive
    [Documentation]    Verifies that removing one of two cart products leaves the other product in the cart.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    @{selected_items}=    Create List    Sauce Labs Backpack    Sauce Labs Bike Light
    ProductAndCartLogic.Add Products To Cart    @{selected_items}
    ProductAndCartLogic.Open Product Cart
    ProductAndCartLogic.Verify Products In Cart    @{selected_items}
    ProductAndCartLogic.Remove Product From Cart    Sauce Labs Backpack
    ProductAndCartLogic.Verify Cart Badge Count    1
    ProductAndCartLogic.Verify Product Is Absent From Cart    Sauce Labs Backpack
    ProductAndCartLogic.Verify Product In Cart    Sauce Labs Bike Light

TC06 - Inventory Page: Product View Mode Persists After Product Detail
    [Tags]    inventory    product_view    navigation    regression
    [Documentation]    Alternates between grid and list views and verifies that the selected layout persists after opening and leaving a product detail page.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    ${first_mode}=    ProductAndCartLogic.Toggle Product View Mode
    ProductAndCartLogic.Verify Product View Persists Through Product Detail    ${first_mode}    Sauce Labs Backpack
    ${second_mode}=    ProductAndCartLogic.Toggle Product View Mode
    Should Not Be Equal As Strings    ${first_mode}    ${second_mode}
    ProductAndCartLogic.Verify Product View Persists Through Product Detail    ${second_mode}    Sauce Labs Backpack
