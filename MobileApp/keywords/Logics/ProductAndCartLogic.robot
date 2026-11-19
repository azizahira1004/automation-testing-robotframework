*** Keywords ***
Add Fixed Product To Cart
    ProductAndCartPages.Verify Product Remove Button Is Not Visible    Sauce Labs Backpack
    @{items}=    Create List    Sauce Labs Backpack
    Add Random Mobile Items To Cart    selected_items=${items}

Verify Product Detail Information
    [Arguments]    ${expected_name}    ${expected_price}
    ${actual_name}    ${description}    ${actual_price}=    ProductAndCartPages.Get Product Detail Information
    Should Be Equal    ${actual_name}    ${expected_name}
    Should Be Equal    ${actual_price}    ${expected_price}
    Should Not Be Empty    ${description}

Verify Cart Badge Count
    [Arguments]    ${expected_count}
    ${actual_count}=    Get Cart Badge Count
    Should Be Equal As Integers    ${actual_count}    ${expected_count}

Toggle Product View Mode
    ${current_mode}=    ProductAndCartPages.Get Product View Mode
    ProductAndCartPages.Toggle Product View
    IF    '${current_mode}' == 'GRID'
        ${expected_mode}=    Set Variable    LIST
    ELSE
        ${expected_mode}=    Set Variable    GRID
    END
    Wait Until Keyword Succeeds    10s    500ms    ProductAndCartPages.Verify Product View Mode    ${expected_mode}
    RETURN    ${expected_mode}

Verify Product View Persists Through Product Detail
    [Arguments]    ${expected_mode}    ${product_name}
    ProductAndCartPages.Verify Product View Mode    ${expected_mode}
    ProductAndCartPages.Open Product Detail By Name    ${product_name}
    ProductAndCartPages.Back To Products From Detail
    ProductAndCartPages.Verify Product View Mode    ${expected_mode}

Verify Product In Cart
    [Arguments]    ${product_name}
    @{expected_items}=    Create List    ${product_name}
    Verify Mobile Items In Cart    @{expected_items}

Add Products To Cart
    [Arguments]    @{product_names}
    Add Random Mobile Items To Cart    selected_items=${product_names}

Verify Products In Cart
    [Arguments]    @{product_names}
    Verify Mobile Items In Cart    @{product_names}

Verify Product Is Absent From Cart
    [Arguments]    ${product_name}
    ProductAndCartPages.Verify Product Is Absent From Cart    ${product_name}

Verify Cart Is Empty
    ProductAndCartPages.Verify Product Cart Is Empty
    Verify Cart Badge Count    0

Open Product Cart
    ProductAndCartPages.Open Product Cart

Remove Product From Cart
    [Arguments]    ${product_name}
    ProductAndCartPages.Remove Product From Cart By Name    ${product_name}

Continue Shopping
    ProductAndCartPages.Continue Shopping From Cart

Checkout From Cart
    ProductAndCartPages.Checkout From Cart

Verify Checkout Information Screen
    Wait Until Element Is Visible    ${INPUT_FIRST_NAME}    timeout=${DEFAULT_TIMEOUT}
