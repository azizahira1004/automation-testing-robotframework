*** Keywords ***
Select Random Product And Get Details
    ${item_count}=    Get Element Count    ${INVENTORY_ITEMS}
    Should Be True    ${item_count} > 0    msg=No inventory products are available.
    ${index}=    Evaluate    random.randint(1, ${item_count})    modules=random
    ${product_name}    ${product_price}=    inventory_page.Get Product Details At Index    ${index}
    inventory_page.Click Product At Index    ${index}
    RETURN    ${product_name}    ${product_price}

Select Random Products
    ${elements}=       Get WebElements    ${INVENTORY_PRODUCT_NAMES}
    ${total_items}=    Get Length    ${elements}
    ${random_count}=   Evaluate    random.randint(1, ${total_items})    modules=random
    ${picked_els}=     Evaluate    random.sample($elements, ${random_count})    modules=random
    @{selected_items}=    Create List
    FOR    ${el}    IN    @{picked_els}
        ${name}=    Get Text    ${el}
        Append To List    ${selected_items}    ${name}
    END
    Log    Selected ${random_count} of ${total_items} products: ${selected_items}
    RETURN    @{selected_items}

Get Random Product Image Src
    ${images}=          Get WebElements    ${INVENTORY_PRODUCT_IMAGES}
    ${count}=           Get Length    ${images}
    ${random_index}=    Evaluate    random.randint(1, ${count})    modules=random
    ${img_locator}=     Set Variable    xpath=(//div[@class='inventory_item']//img[contains(@class,'inventory_item_img')])[${random_index}]
    ${name_locator}=    Set Variable    xpath=(//div[@class='inventory_item'])[${random_index}]//div[contains(@class,'inventory_item_name')]
    Wait Until Element Is Visible    ${img_locator}
    ${product_name}=    Get Text    ${name_locator}
    ${img_src}=    Get Element Attribute    ${img_locator}    src
    RETURN    ${product_name}    ${img_src}

Verify Selected Inventory Buttons Functionality
    [Arguments]    ${selected_items}    ${allow_broken}=${FALSE}
    @{broken_logs}=    Create List
    ${count_to_check}=    Get Length    ${selected_items}
    FOR    ${product_name}    IN    @{selected_items}
        Log    Checking selected product button: ${product_name}
        ${add_btn}=    Set Variable    xpath=//div[text()='${product_name}']/ancestor::div[@class='inventory_item']//button[text()='Add to cart']
        ${remove_btn}=    Set Variable    xpath=//div[text()='${product_name}']/ancestor::div[@class='inventory_item']//button[text()='Remove']
        ${starts_with_add}=    Run Keyword And Return Status    Element Should Be Visible    ${add_btn}
        IF    ${starts_with_add}
            ${step1_ok}=    Click And Verify Toggle    ${add_btn}    ${remove_btn}
            IF    not ${step1_ok}
                Append To List    ${broken_logs}    [BROKEN ADD] ${product_name}: Add to cart did not change to Remove.
                CONTINUE
            END
            ${step2_ok}=    Click And Verify Toggle    ${remove_btn}    ${add_btn}
            IF    not ${step2_ok}
                Append To List    ${broken_logs}    [BROKEN REMOVE] ${product_name}: Remove did not change back to Add to cart.
            END
        ELSE
            ${step1_ok}=    Click And Verify Toggle    ${remove_btn}    ${add_btn}
            IF    not ${step1_ok}
                Append To List    ${broken_logs}    [BROKEN REMOVE] ${product_name}: initial Remove did not change to Add to cart.
                CONTINUE
            END
            ${step2_ok}=    Click And Verify Toggle    ${add_btn}    ${remove_btn}
            IF    not ${step2_ok}
                Append To List    ${broken_logs}    [BROKEN ADD] ${product_name}: Add to cart did not change back to Remove.
            END
        END
    END
    ${broken_count}=    Get Length    ${broken_logs}
    ${summary}=    Catenate    SEPARATOR=\n    @{broken_logs}
    IF    ${allow_broken}
        Log    Checked ${count_to_check} selected product(s); found ${broken_count} broken button transition(s):\n${summary}
    ELSE
        Should Be Equal As Integers    ${broken_count}    0
        ...    msg=Found ${broken_count} broken button transition(s):\n${summary}
    END

Add Random Items To Cart
    [Arguments]    ${selected_items}=${NONE}    ${allow_broken}=${FALSE}
    IF    $selected_items is None
        @{selected_items}=    Select Random Products
    END
    FOR    ${product_name}    IN    @{selected_items}
        ${add_btn}=    Set Variable    xpath=//div[text()='${product_name}']/ancestor::div[@class='inventory_item']//button[text()='Add to cart']
        ${remove_btn}=    Set Variable    xpath=//div[text()='${product_name}']/ancestor::div[@class='inventory_item']//button[text()='Remove']
        ${is_not_added_yet}=    Run Keyword And Return Status    Element Should Be Visible    ${add_btn}
        IF    ${is_not_added_yet}
            Scroll Element Into View    ${add_btn}
            Click Button    ${add_btn}
            IF    ${allow_broken}
                Run Keyword And Return Status    Wait Until Element Is Visible    ${remove_btn}    timeout=2s
            ELSE
                Wait Until Element Is Visible    ${remove_btn}    timeout=5s
            END
        ELSE
            Log    Product '${product_name}' is already in the cart.
        END
    END
    RETURN    @{selected_items}

Click And Verify Toggle
    [Arguments]    ${click_locator}    ${expected_next_locator}
    Scroll Element Into View    ${click_locator}
    Click Button    ${click_locator}
    ${is_toggled}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${expected_next_locator}    timeout=1s
    RETURN    ${is_toggled}
