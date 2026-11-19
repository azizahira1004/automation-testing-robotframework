*** Settings ***
Documentation     Tests product sorting and filtering in the Swag Labs mobile app.
Resource          ../resource.robot
Suite Setup       setup.Spawn Appium Server
Test Setup        setup.Open App
Test Teardown     Close Application
Suite Teardown    teardown.Close Appium Server

*** Test Cases ***
TC01 - Verify Default Sort Is Name A To Z
    [Tags]    filter    sort    smoke
    [Documentation]    Verifies that products are initially sorted by name from A to Z.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    FilterLogic.Verify Default Sort Is Name A To Z

TC02 - Verify Sort Products By Name Z To A
    [Tags]    filter    sort
    [Documentation]    Verifies that selecting Name (Z to A) sorts product names in descending order.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    FilterLogic.Select Mobile Product Sort Option    Name (Z to A)
    FilterLogic.Verify Mobile Product Names Sorted    DESC

TC03 - Verify Sort Products By Price Low To High
    [Tags]    filter    sort
    [Documentation]    Verifies that selecting Price (low to high) sorts product prices in ascending order.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    FilterLogic.Select Mobile Product Sort Option    Price (low to high)
    FilterLogic.Verify Mobile Product Prices Sorted    ASC

TC04 - Verify Sort Products By Price High To Low
    [Tags]    filter    sort
    [Documentation]    Verifies that selecting Price (high to low) sorts product prices in descending order.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    FilterLogic.Select Mobile Product Sort Option    Price (high to low)
    FilterLogic.Verify Mobile Product Prices Sorted    DESC

TC05 - Verify Switching Back To Name A To Z From Another Filter
    [Tags]    filter    sort
    [Documentation]    Verifies that the product list can be switched back to Name (A to Z) after applying another sort option.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    FilterLogic.Select Mobile Product Sort Option    Price (high to low)
    FilterLogic.Verify Mobile Product Prices Sorted    DESC
    FilterLogic.Select Mobile Product Sort Option    Name (A to Z)
    FilterPages.Scroll Product List To Top
    FilterLogic.Verify Mobile Product Names Sorted    ASC

TC06 - Verify Add To Cart Adds Correct Item After Filtering
    [Tags]    filter    integration
    [Documentation]    Verifies that the selected product is added to the cart correctly after the inventory has been sorted.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    FilterLogic.Select Mobile Product Sort Option    Name (Z to A)
    ${first_product_name}=    FilterLogic.Get First Product Name
    FilterLogic.Add Product To Cart    ${first_product_name}
    FilterLogic.Open Cart After Adding Product
    FilterLogic.Verify Product Is In Cart    ${first_product_name}
