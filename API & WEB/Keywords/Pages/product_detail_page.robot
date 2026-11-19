*** Variables ***
${DETAIL_ITEM_NAME}          class=inventory_details_name
${DETAIL_ITEM_DESC}          class=inventory_details_desc
${DETAIL_ITEM_PRICE}         class=inventory_details_price
${BTN_ADD_TO_CART}           id=add-to-cart
${BTN_BACK_TO_PRODUCTS}      id=back-to-products

*** Keywords ***
Verify Product Detail Information
    [Arguments]    ${expected_name}    ${expected_price}
    Wait Until Element Is Visible    ${DETAIL_ITEM_NAME}
    Element Text Should Be           ${DETAIL_ITEM_NAME}     ${expected_name}
    Element Text Should Be           ${DETAIL_ITEM_PRICE}    ${expected_price}
    ${desc_text}=    Get Text        ${DETAIL_ITEM_DESC}
    Should Not Be Empty              ${desc_text}

Add Product To Cart From Detail Page
    Wait Until Element Is Visible    ${BTN_ADD_TO_CART}
    Click Button                     ${BTN_ADD_TO_CART}

Click Back To Products
    Wait Until Element Is Visible    ${BTN_BACK_TO_PRODUCTS}
    Click Button                     ${BTN_BACK_TO_PRODUCTS}