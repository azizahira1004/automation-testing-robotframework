*** Keywords ***
Fill Shipping Information
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    checkout_page.Enter Shipping Information    ${first_name}    ${last_name}    ${postal_code}
    checkout_page.Click Continue Button

Verify Shipping Input Error
    [Arguments]    ${expected_error}
    ${error_message}=    checkout_page.Get Shipping Input Error
    Should Contain    ${error_message}    ${expected_error}

Complete Order
    checkout_page.Click Finish Button

Click Button Cancel Checkout
    checkout_page.Click Cancel Button

Verify Order Confirmation
    [Arguments]    ${expected_header}=Thank you for your order!
    checkout_complete_page.Check Order Confirmation Screen    ${expected_header}
