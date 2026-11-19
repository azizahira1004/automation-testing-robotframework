*** Settings ***
Resource          ../resource.robot
Suite Setup       setup.Spawn Appium Server
Test Setup        setup.Open App
Test Teardown     teardown.Terminate Mobile App And Close Session
Suite Teardown    teardown.Close Appium Server

*** Test Cases ***
TC01 - Fixed One Product Checkout Flow
    [Documentation]    Checks Add/Remove button behavior, the cart badge and contents, and completes checkout with one fixed product.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    @{selected_items}=    Select Fixed Mobile Checkout Product
    Verify Mobile Selected Buttons Functionality    ${selected_items}    allow_broken=${FALSE}
    @{selected_items}=    Add Random Mobile Items To Cart    selected_items=${selected_items}    allow_broken=${FALSE}
    Open Mobile Cart
    Verify Mobile Items In Cart    @{selected_items}
    Proceed Mobile Checkout
    Fill Mobile Shipping Information    Ira    Nurazizah    16411
    Complete Mobile Order
    Verify Mobile Order Confirmation    THANK YOU

TC02 - Validate Required Shipping Fields Error During Checkout
    [Documentation]    Verifies the required-field errors for a missing postal code, last name, and first name during checkout.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    @{selected_items}=    Select Fixed Mobile Checkout Product
    @{selected_items}=    Add Random Mobile Items To Cart    selected_items=${selected_items}
    Open Mobile Cart
    Verify Mobile Items In Cart    @{selected_items}

    Proceed Mobile Checkout
    Fill Mobile Shipping Information    Ira    Nurazizah    ${EMPTY}
    Verify Mobile Shipping Input Error    Postal Code is required

    Fill Mobile Shipping Information    Ira    ${EMPTY}    16411
    Verify Mobile Shipping Input Error    Last Name is required

    Fill Mobile Shipping Information    ${EMPTY}    Nurazizah    16411
    Verify Mobile Shipping Input Error    First Name is required

TC03 - Multi Product Checkout Completes Successfully
    [Tags]    checkout    multi_item    positive
    [Documentation]    Completes checkout with two products, verifies the checkout overview, returns to inventory, and confirms that the cart is cleared.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    @{selected_items}=    Create List    Sauce Labs Backpack    Sauce Labs Bike Light
    @{selected_items}=    Add Random Mobile Items To Cart    selected_items=${selected_items}    allow_broken=${FALSE}
    Open Mobile Cart
    Verify Mobile Items In Cart    @{selected_items}
    Proceed Mobile Checkout
    Fill Mobile Shipping Information    Ira    Nurazizah    16411
    CheckoutPagePages.Verify Checkout Overview Screen
    Complete Mobile Order
    Verify Mobile Order Confirmation    THANK YOU
    CheckoutPagePages.Click Back Home After Complete
    HomepageLogic.Verify On Homepage
    ProductAndCartLogic.Verify Cart Badge Count    0

TC04 - Cancel Checkout Returns To Inventory With Cart Preserved
    [Tags]    checkout    cancellation    edge_case
    [Documentation]    Verifies that canceling the checkout information step returns to inventory while preserving the cart item.
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    @{selected_items}=    Select Fixed Mobile Checkout Product
    Add Random Mobile Items To Cart    selected_items=${selected_items}
    Open Mobile Cart
    Verify Mobile Items In Cart    @{selected_items}
    Proceed Mobile Checkout
    CheckoutPagePages.Cancel Mobile Checkout Information
    ProductAndCartLogic.Verify Cart Badge Count    1
    ProductAndCartPages.Verify Product Remove Button Is Visible    Sauce Labs Backpack