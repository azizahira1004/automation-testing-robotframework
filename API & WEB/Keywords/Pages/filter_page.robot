*** Variables ***
${SORT_DROPDOWN}              css:[data-test="product-sort-container"]
${ACTIVE_SORT_OPTION}         css:[data-test="active-option"]
${INVENTORY_ITEM_NAME}        css:[data-test="inventory-item-name"]
${INVENTORY_ITEM_PRICE}       css:[data-test="inventory-item-price"]
${FIRST_ITEM_NAME}            xpath=(//*[@data-test="inventory-item-name"])[1]
${FIRST_ADD_TO_CART_BTN}      xpath=(//button[contains(@data-test, "add-to-cart")])[1]

*** Keywords ***
Click And Select Filter Option
    [Arguments]    ${option_value}    ${expected_label}
    Wait Until Element Is Visible    ${SORT_DROPDOWN}    10s
    Click Element                    ${SORT_DROPDOWN}
    ${option_locator}=    Set Variable    css=[data-test="product-sort-container"] option[value="${option_value}"]
    Wait Until Element Is Visible    ${option_locator}    5s
    Click Element                    ${option_locator}
    Element Text Should Be           ${ACTIVE_SORT_OPTION}    ${expected_label}

Read First Product Name
    Wait Until Element Is Visible    ${FIRST_ITEM_NAME}    10s
    ${product_name}=    Get Text     ${FIRST_ITEM_NAME}
    RETURN    ${product_name}

Click First Product Add Button
    Wait Until Element Is Visible    ${FIRST_ADD_TO_CART_BTN}    10s
    Click Button                     ${FIRST_ADD_TO_CART_BTN}
