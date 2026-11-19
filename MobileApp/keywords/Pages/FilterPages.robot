*** Variables ***
${MOBILE_SORT_SELECTOR}           accessibility_id=test-Modal Selector Button
${MOBILE_ITEM_TITLES}             xpath=//android.widget.TextView[@content-desc="test-Item title"]

*** Keywords ***
Verify Sort Selector Is Visible
    Wait Until Element Is Visible    ${MOBILE_SORT_SELECTOR}    timeout=${DEFAULT_TIMEOUT}

Select Mobile Product Sort Option
    [Arguments]    ${option_label}
    Verify Sort Selector Is Visible
    Click Element    ${MOBILE_SORT_SELECTOR}
    ${option_locator}=    Set Variable    xpath=//android.widget.TextView[@text="${option_label}"]
    Wait Until Element Is Visible    ${option_locator}    timeout=${DEFAULT_TIMEOUT}
    Click Element    ${option_locator}

Get Visible Product Name Price Pairs
    ${source}=    Get Source
    # Ignore partially visible cards until both the title and price are in the accessibility tree.
    ${pairs}=    Evaluate
    ...    [(next(e.attrib.get('text') for e in card.iter() if e.attrib.get('content-desc') == 'test-Item title'), next(e.attrib.get('text') for e in card.iter() if e.attrib.get('content-desc') == 'test-Price')) for card in __import__('xml.etree.ElementTree', fromlist=['ElementTree']).fromstring($source).iter() if card.attrib.get('content-desc') == 'test-Item' and any(e.attrib.get('content-desc') == 'test-Item title' for e in card.iter()) and any(e.attrib.get('content-desc') == 'test-Price' for e in card.iter())]
    RETURN    ${pairs}

Scroll Product List To Top
    FOR    ${index}    IN RANGE    2
        Scroll Up Safe    1s
    END

Get First Product Name
    @{name_elements}=    Get Webelements    ${MOBILE_ITEM_TITLES}
    Should Not Be Empty    ${name_elements}
    ${name}=    Get Text    ${name_elements}[0]
    RETURN    ${name}

Add Product To Cart By Name
    [Arguments]    ${product_name}
    ${card_locator}=    Set Variable    xpath=//android.widget.TextView[@text="${product_name}" and @content-desc="test-Item title"]/ancestor::android.view.ViewGroup[.//*[@content-desc="test-ADD TO CART" or @content-desc="test-REMOVE"]][1]
    ${add_locator}=    Set Variable    ${card_locator}//*[@content-desc="test-ADD TO CART"]
    ${remove_locator}=    Set Variable    ${card_locator}//*[@content-desc="test-REMOVE"]
    Wait Until Element Is Visible    ${add_locator}    timeout=${DEFAULT_TIMEOUT}
    Click Element    ${add_locator}
    Wait Until Element Is Visible    ${remove_locator}    timeout=${DEFAULT_TIMEOUT}

Verify Product Is In Cart
    [Arguments]    ${product_name}
    ${product_locator}=    Set Variable    xpath=//android.widget.TextView[@text="${product_name}"]
    Wait Until Element Is Visible    ${product_locator}    timeout=${DEFAULT_TIMEOUT}
    Page Should Contain Element    ${product_locator}
