*** Variables ***
${PRODUCT_DETAIL_SCREEN}             accessibility_id=test-Inventory item page
${PRODUCT_DETAIL_NAME}               xpath=//*[@content-desc="test-Description"]/android.widget.TextView[1]
${PRODUCT_DETAIL_DESCRIPTION}        xpath=//*[@content-desc="test-Description"]/android.widget.TextView[2]
${PRODUCT_DETAIL_PRICE}              accessibility_id=test-Price
${PRODUCT_DETAIL_BACK_BUTTON}        accessibility_id=test-BACK TO PRODUCTS
${PRODUCT_DETAIL_ADD_BUTTON}         accessibility_id=test-ADD TO CART
${PRODUCT_DETAIL_REMOVE_BUTTON}      accessibility_id=test-REMOVE
${PRODUCT_VIEW_TOGGLE}               accessibility_id=test-Toggle
${PRODUCT_CART_SCREEN}                accessibility_id=test-Cart Content
${PRODUCT_CART_CHECKOUT_BUTTON}      accessibility_id=test-CHECKOUT
${PRODUCT_CART_CONTINUE_BUTTON}     accessibility_id=test-CONTINUE SHOPPING
${PRODUCT_CART_ITEM_CARDS}           xpath=//android.view.ViewGroup[@content-desc="test-Item"]
${PRODUCT_CART_REMOVE_BUTTONS}       accessibility_id=test-REMOVE

*** Keywords ***
Get Inventory Product Price
    [Arguments]    ${product_name}
    ${card_locator}=    Set Variable    xpath=//android.widget.TextView[@text="${product_name}" and @content-desc="test-Item title"]/ancestor::android.view.ViewGroup[@content-desc="test-Item"][1]
    ${price_locator}=    Set Variable    ${card_locator}//*[@content-desc="test-Price"]
    Wait Until Element Is Visible    ${price_locator}    timeout=${DEFAULT_TIMEOUT}
    ${price}=    Get Text    ${price_locator}
    RETURN    ${price}

Open Product Detail By Name
    [Arguments]    ${product_name}
    ${title_locator}=    Set Variable    xpath=//android.widget.TextView[@text="${product_name}" and @content-desc="test-Item title"]
    Wait Until Element Is Visible    ${title_locator}    timeout=${DEFAULT_TIMEOUT}
    Click Element    ${title_locator}
    Wait Until Element Is Visible    ${PRODUCT_DETAIL_SCREEN}    timeout=${DEFAULT_TIMEOUT}

Get Product Detail Information
    Wait Until Element Is Visible    ${PRODUCT_DETAIL_NAME}    timeout=${DEFAULT_TIMEOUT}
    ${name}=    Get Text    ${PRODUCT_DETAIL_NAME}
    ${description}=    Get Text    ${PRODUCT_DETAIL_DESCRIPTION}
    ${price}=    Get Text    ${PRODUCT_DETAIL_PRICE}
    RETURN    ${name}    ${description}    ${price}

Add Product To Cart From Detail
    Scroll Element Into View    ${PRODUCT_DETAIL_ADD_BUTTON}    max_swipes=5
    Click Element    ${PRODUCT_DETAIL_ADD_BUTTON}
    Wait Until Element Is Visible    ${PRODUCT_DETAIL_REMOVE_BUTTON}    timeout=${DEFAULT_TIMEOUT}

Back To Products From Detail
    Wait Until Element Is Visible    ${PRODUCT_DETAIL_BACK_BUTTON}    timeout=${DEFAULT_TIMEOUT}
    Click Element    ${PRODUCT_DETAIL_BACK_BUTTON}
    Wait Until Element Is Visible    ${INVENTORY_CONTAINER}    timeout=${DEFAULT_TIMEOUT}

Remove Product From Inventory By Name
    [Arguments]    ${product_name}
    ${card_locator}=    Set Variable    xpath=//android.widget.TextView[@text="${product_name}" and @content-desc="test-Item title"]/ancestor::android.view.ViewGroup[.//*[@content-desc="test-ADD TO CART" or @content-desc="test-REMOVE"]][1]
    ${remove_locator}=    Set Variable    ${card_locator}//*[@content-desc="test-REMOVE"]
    ${add_locator}=    Set Variable    ${card_locator}//*[@content-desc="test-ADD TO CART"]
    Wait Until Element Is Visible    ${remove_locator}    timeout=${DEFAULT_TIMEOUT}
    Click Element    ${remove_locator}
    Wait Until Element Is Visible    ${add_locator}    timeout=${DEFAULT_TIMEOUT}

Verify Product Remove Button Is Not Visible
    [Arguments]    ${product_name}
    ${card_locator}=    Set Variable    xpath=//android.widget.TextView[@text="${product_name}" and @content-desc="test-Item title"]/ancestor::android.view.ViewGroup[.//*[@content-desc="test-ADD TO CART" or @content-desc="test-REMOVE"]][1]
    ${remove_locator}=    Set Variable    ${card_locator}//*[@content-desc="test-REMOVE"]
    ${remove_visible}=    Run Keyword And Return Status    Expect Element    ${remove_locator}    visible    timeout=100ms    retry_interval=100ms
    Should Be Equal    ${remove_visible}    ${FALSE}

Verify Product Remove Button Is Visible
    [Arguments]    ${product_name}
    ${card_locator}=    Set Variable    xpath=//android.widget.TextView[@text="${product_name}" and @content-desc="test-Item title"]/ancestor::android.view.ViewGroup[.//*[@content-desc="test-ADD TO CART" or @content-desc="test-REMOVE"]][1]
    ${remove_locator}=    Set Variable    ${card_locator}//*[@content-desc="test-REMOVE"]
    Wait Until Element Is Visible    ${remove_locator}    timeout=${DEFAULT_TIMEOUT}

Get Product View Mode
    ${source}=    Get Source
    ${item_bounds}=    Evaluate    [tuple(int(value) for value in node.attrib['bounds'].replace('][', ',').strip('[]').split(',')) for node in __import__('xml.etree.ElementTree', fromlist=['ElementTree']).fromstring($source).iter() if node.attrib.get('content-desc') == 'test-Item']
    Should Be True    len($item_bounds) >= 2    msg=Expected at least two visible product cards to identify the view mode.
    ${mode}=    Evaluate    'GRID' if $item_bounds[0][1] == $item_bounds[1][1] and $item_bounds[0][0] != $item_bounds[1][0] else 'LIST'
    RETURN    ${mode}

Verify Product View Mode
    [Arguments]    ${expected_mode}
    ${actual_mode}=    Get Product View Mode
    Should Be Equal As Strings    ${actual_mode}    ${expected_mode}

Toggle Product View
    Wait Until Element Is Visible    ${PRODUCT_VIEW_TOGGLE}    timeout=${DEFAULT_TIMEOUT}
    Click Element    ${PRODUCT_VIEW_TOGGLE}

Open Product Cart
    Wait Until Element Is Visible    ${BTN_CART}    timeout=${DEFAULT_TIMEOUT}
    Click Element    ${BTN_CART}
    Wait Until Element Is Visible    ${PRODUCT_CART_SCREEN}    timeout=${DEFAULT_TIMEOUT}

Verify Product Cart Is Empty
    ${has_cart_items}=    Run Keyword And Return Status    Expect Element    ${PRODUCT_CART_ITEM_CARDS}    visible    timeout=100ms    retry_interval=100ms
    ${has_remove_buttons}=    Run Keyword And Return Status    Expect Element    ${PRODUCT_CART_REMOVE_BUTTONS}    visible    timeout=100ms    retry_interval=100ms
    Should Be Equal    ${has_cart_items}    ${FALSE}
    Should Be Equal    ${has_remove_buttons}    ${FALSE}

Remove Product From Cart By Name
    [Arguments]    ${product_name}
    ${cart_item_locator}=    Set Variable    xpath=//android.view.ViewGroup[@content-desc="test-Item"][.//android.widget.TextView[@text="${product_name}"]]
    ${remove_locator}=    Set Variable    ${cart_item_locator}//*[@content-desc="test-REMOVE"]
    Wait Until Element Is Visible    ${remove_locator}    timeout=${DEFAULT_TIMEOUT}
    Click Element    ${remove_locator}
    Wait Until Keyword Succeeds    5s    500ms    Verify Cart Item Is Removed    ${cart_item_locator}

Verify Cart Item Is Removed
    [Arguments]    ${cart_item_locator}
    ${item_visible}=    Run Keyword And Return Status    Expect Element    ${cart_item_locator}    visible    timeout=100ms    retry_interval=100ms
    Should Be Equal    ${item_visible}    ${FALSE}

Verify Product Is Absent From Cart
    [Arguments]    ${product_name}
    ${cart_item_locator}=    Set Variable    xpath=//android.view.ViewGroup[@content-desc="test-Item"][.//android.widget.TextView[@text="${product_name}"]]
    ${item_visible}=    Run Keyword And Return Status    Expect Element    ${cart_item_locator}    visible    timeout=100ms    retry_interval=100ms
    Should Be Equal    ${item_visible}    ${FALSE}

Continue Shopping From Cart
    Scroll Element Into View    ${PRODUCT_CART_CONTINUE_BUTTON}    max_swipes=5
    Wait Until Element Is Visible    ${PRODUCT_CART_CONTINUE_BUTTON}    timeout=${DEFAULT_TIMEOUT}
    Click Element    ${PRODUCT_CART_CONTINUE_BUTTON}
    Wait Until Element Is Visible    ${INVENTORY_CONTAINER}    timeout=${DEFAULT_TIMEOUT}

Checkout From Cart
    Scroll Element Into View    ${PRODUCT_CART_CHECKOUT_BUTTON}    max_swipes=5
    Wait Until Element Is Visible    ${PRODUCT_CART_CHECKOUT_BUTTON}    timeout=${DEFAULT_TIMEOUT}
    Click Element    ${PRODUCT_CART_CHECKOUT_BUTTON}
    Wait Until Element Is Visible    ${INPUT_FIRST_NAME}    timeout=${DEFAULT_TIMEOUT}
