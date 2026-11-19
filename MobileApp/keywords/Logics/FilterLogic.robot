*** Keywords ***
Verify Default Sort Is Name A To Z
    FilterPages.Verify Sort Selector Is Visible
    Verify Mobile Product Names Sorted    ASC

Select Mobile Product Sort Option
    [Arguments]    ${option_label}
    FilterPages.Select Mobile Product Sort Option    ${option_label}

Verify Mobile Product Names Sorted
    [Arguments]    ${order}=ASC
    ${pairs}=    Get All Mobile Product Name Price Pairs
    @{actual_names}=    Create List
    FOR    ${pair}    IN    @{pairs}
        Append To List    ${actual_names}    ${pair}[0]
    END
    ${reverse}=    Set Variable If    '${order}' == 'DESC'    ${TRUE}    ${FALSE}
    ${expected_names}=    Evaluate    sorted($actual_names, reverse=$reverse)
    Lists Should Be Equal    ${actual_names}    ${expected_names}
    Log    Actual product names: ${actual_names}
    Log    Expected product names: ${expected_names}

Verify Mobile Product Prices Sorted
    [Arguments]    ${order}=ASC
    ${pairs}=    Get All Mobile Product Name Price Pairs
    @{actual_prices}=    Create List
    FOR    ${pair}    IN    @{pairs}
        ${price_text}=    Set Variable    ${pair}[1]
        ${price}=    Evaluate    float($price_text.replace('$', ''))
        Append To List    ${actual_prices}    ${price}
    END
    ${reverse}=    Set Variable If    '${order}' == 'DESC'    ${TRUE}    ${FALSE}
    ${expected_prices}=    Evaluate    sorted($actual_prices, reverse=$reverse)
    Lists Should Be Equal    ${actual_prices}    ${expected_prices}
    Log    Actual product prices: ${actual_prices}
    Log    Expected product prices: ${expected_prices}

Get First Product Name
    ${product_name}=    FilterPages.Get First Product Name
    RETURN    ${product_name}

Add Product To Cart
    [Arguments]    ${product_name}
    FilterPages.Add Product To Cart By Name    ${product_name}

Open Cart After Adding Product
    Open Mobile Cart

Verify Product Is In Cart
    [Arguments]    ${product_name}
    FilterPages.Verify Product Is In Cart    ${product_name}

Get All Mobile Product Name Price Pairs
    @{all_pairs}=    Create List
    @{collected_names}=    Create List
    FOR    ${scroll_index}    IN RANGE    8
        ${visible_pairs}=    FilterPages.Get Visible Product Name Price Pairs
        FOR    ${pair}    IN    @{visible_pairs}
            ${product_name}=    Set Variable    ${pair}[0]
            IF    $product_name not in $collected_names
                Append To List    ${collected_names}    ${product_name}
                Append To List    ${all_pairs}    ${pair}
            END
        END
        ${product_count}=    Get Length    ${all_pairs}
        IF    ${product_count} == 6
            BREAK
        END
        Scroll Down Safe    600ms
    END
    ${product_count}=    Get Length    ${all_pairs}
    Should Be Equal As Integers    ${product_count}    6    msg=Expected to collect all 6 mobile products.
    RETURN    ${all_pairs}
