*** Variables ***
${BTN_CHECKOUT}             id=checkout
${CART_ITEM_NAMES}          css=.cart_item .inventory_item_name
${CART_ITEM_NAME}           class=inventory_item_name
${BTN_REMOVE_BACKPACK_CART}    id=remove-sauce-labs-backpack
${BTN_CONTINUE_SHOPPING}    id=continue-shopping
${ICON_CART}                 class=shopping_cart_link

*** Keywords ***
Click Cart Icon
    Click Element    ${ICON_CART}

Get Cart Item Names
    Wait Until Element Is Visible    ${BTN_CHECKOUT}    5s
    @{actual_items}=       Create List
    @{cart_elements}=      Get WebElements    ${CART_ITEM_NAMES}

    FOR    ${el}    IN    @{cart_elements}
        ${name}=    Get Text    ${el}
        Append To List    ${actual_items}    ${name}
    END
    RETURN    @{actual_items}

Click Checkout Button
    Wait Until Element Is Visible    ${BTN_CHECKOUT}    5s
    Click Button    ${BTN_CHECKOUT}

Verify Cart Page Loaded
    Wait Until Location Is    ${CART_URL}

Verify Item In Cart
    [Arguments]    ${expected_item_name}
    Element Text Should Be    ${CART_ITEM_NAME}    ${expected_item_name}

Remove Backpack From Cart
    Click Button    ${BTN_REMOVE_BACKPACK_CART}
    Element Should Not Be Visible    ${CART_ITEM_NAME}

Click Continue Shopping
    Click Button    ${BTN_CONTINUE_SHOPPING}

Verify Redirected To Checkout Step One
    Location Should Be    ${CHECKOUT_STEP_ONE_URL}