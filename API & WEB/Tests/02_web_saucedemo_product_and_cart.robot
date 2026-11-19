*** Settings ***
Documentation     Pengujian interaksi manajemen item di halaman Inventory,
...               Product Detail Page, dan Cart Page.
Resource          ${EXECDIR}/resources.txt
Test Setup        Open Homepage
Test Teardown     Capture Failed and Close All Browsers
Suite Teardown    Close All Browsers

*** Test Cases ***
TC01 - Inventory Page: Add And Remove Product Directly
    [Tags]    inventory    cart
    login_logic.Login With Credentials    ${STANDARD_USER.USERNAME}    ${STANDARD_USER.PASSWORD}
    inventory_page.Verify Inventory Page Loaded
    inventory_page.Add Backpack To Cart From Inventory
    inventory_page.Verify Cart Badge Count    1
    inventory_page.Remove Backpack From Inventory
    inventory_page.Verify Cart Badge Is Empty

TC02 - Product Detail Page: Verify Info And Add To Cart
    [Tags]    product_detail    positive    dynamic
    login_logic.Login With Credentials    ${STANDARD_USER.USERNAME}    ${STANDARD_USER.PASSWORD}
    inventory_page.Verify Inventory Page Loaded
    ${selected_name}    ${selected_price} =    inventory_logic.Select Random Product And Get Details
    product_detail_page.Verify Product Detail Information    ${selected_name}    ${selected_price}
    product_detail_page.Add Product To Cart From Detail Page
    inventory_page.Verify Cart Badge Count    1
    product_detail_page.Click Back To Products
    inventory_page.Verify Inventory Page Loaded
    inventory_page.Verify Specific Product Remove Button Is Displayed    ${selected_name}

TC03 - Cart Page: Remove Item And Continue Shopping
    [Tags]    cart    navigation
    login_logic.Login With Credentials    ${STANDARD_USER.USERNAME}    ${STANDARD_USER.PASSWORD}
    inventory_page.Verify Inventory Page Loaded
    inventory_page.Add Backpack To Cart From Inventory
    cart_logic.Go To Cart Page
    cart_logic.Verify Product Is In Cart    Sauce Labs Backpack
    cart_page.Remove Backpack From Cart
    inventory_page.Verify Cart Badge Is Empty
    cart_page.Click Continue Shopping
    inventory_page.Verify Inventory Page Loaded
    inventory_page.Verify Cart Badge Is Empty

TC04 - Cart Page: Edge Case Checkout With Empty Cart
    [Tags]    cart    edge_case
    login_logic.Login With Credentials    ${STANDARD_USER.USERNAME}    ${STANDARD_USER.PASSWORD}
    inventory_page.Verify Inventory Page Loaded
    cart_logic.Go To Cart Page
    inventory_page.Verify Cart Badge Is Empty
    cart_logic.Proceed To Checkout
    cart_page.Verify Redirected To Checkout Step One