*** Keywords ***
Go To Cart Page
    cart_page.Click Cart Icon
    cart_page.Verify Cart Page Loaded

Verify Items In Cart
    [Arguments]    @{expected_items}
    @{actual_items}=    cart_page.Get Cart Item Names
    Lists Should Be Equal    ${actual_items}    ${expected_items}

Proceed To Checkout
    cart_page.Click Checkout Button

Verify Product Is In Cart
    [Arguments]    ${expected_product_name}
    cart_page.Verify Item In Cart    ${expected_product_name}
