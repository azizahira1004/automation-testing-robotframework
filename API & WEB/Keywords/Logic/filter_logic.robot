*** Keywords ***
Verify Default Sort Is Name A To Z
    Wait Until Element Is Visible    ${SORT_DROPDOWN}    10s
    Element Text Should Be    ${ACTIVE_SORT_OPTION}    Name (A to Z)
    Verify Products Are Sorted By Name    ASC

Select Product Sort Option
    [Arguments]    ${option_value}    ${expected_label}
    filter_page.Click And Select Filter Option    ${option_value}    ${expected_label}

Verify Products Are Sorted By Name
    [Arguments]    ${order}=ASC
    @{elements}=    Get WebElements    ${INVENTORY_ITEM_NAME}
    @{actual_names}=    Create List
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        Append To List    ${actual_names}    ${text}
    END
    ${is_reverse}=    Set Variable If    '${order}' == 'DESC'    ${TRUE}    ${FALSE}
    ${expected_names}=    Evaluate    sorted($actual_names, reverse=$is_reverse)
    Lists Should Be Equal    ${actual_names}    ${expected_names}
    Log    Actual product names: ${actual_names}
    Log    Expected product names: ${expected_names}

Verify Products Are Sorted By Price
    [Arguments]    ${order}=ASC
    @{elements}=    Get WebElements    ${INVENTORY_ITEM_PRICE}
    @{actual_prices}=    Create List
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        ${clean_price}=    Evaluate    float($text.replace('$', ''))
        Append To List    ${actual_prices}    ${clean_price}
    END
    ${is_reverse}=    Set Variable If    '${order}' == 'DESC'    ${TRUE}    ${FALSE}
    ${expected_prices}=    Evaluate    sorted($actual_prices, reverse=$is_reverse)
    Lists Should Be Equal    ${actual_prices}    ${expected_prices}
    Log    Actual product prices: ${actual_prices}
    Log    Expected product prices: ${expected_prices}

Get First Product Name
    ${product_name}=    filter_page.Read First Product Name
    RETURN    ${product_name}

Add First Product To Cart
    filter_page.Click First Product Add Button
