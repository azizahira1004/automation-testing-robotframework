*** Variables ***
${INVENTORY_CONTAINER}          id=inventory_container
${BTN_ADD_BACKPACK}             id=add-to-cart-sauce-labs-backpack
${BTN_ADD_BIKE_LIGHT}           id=add-to-cart-sauce-labs-bike-light
${BTN_ADD_BOLT_T_SHIRT}         id=add-to-cart-sauce-labs-bolt-t-shirt
${BTN_ADD_FLEECE_JACKET}        id=add-to-cart-sauce-labs-fleece-jacket
${BTN_ADD_ONESIE}               id=add-to-cart-sauce-labs-onesie
${BTN_ADD_RED_T_SHIRT}          id=add-to-cart-test.allthethings()-t-shirt-(red)
${BADGE_CART}                   class=shopping_cart_badge
${INVENTORY_PRODUCT_IMAGES}     xpath=//div[@class='inventory_item']//img[contains(@class,'inventory_item_img')]
${INVENTORY_ITEMS}              css=.inventory_item
${INVENTORY_PRODUCT_NAMES}      xpath=//div[@class='inventory_item_name ']
${LBL_ITEM_NAMES}               css=.inventory_item_name
@{ERROR_USER_VALID_ITEMS}       Sauce Labs Backpack
${BTN_REMOVE_BACKPACK}       id=remove-sauce-labs-backpack

*** Keywords ***
Verify Inventory Page Loaded
    [Arguments]    ${timeout}=10s
    Wait Until Element Is Visible    ${INVENTORY_CONTAINER}    ${timeout}
    Wait Until Location Is           ${INVENTORY_URL}
    Sleep       0.8s
    Evaluate    pyautogui.press('enter')    modules=pyautogui

Add Backpack To Cart From Inventory
    Click Button    ${BTN_ADD_BACKPACK}
    Element Should Be Visible    ${BTN_REMOVE_BACKPACK}

Remove Backpack From Inventory
    Click Button    ${BTN_REMOVE_BACKPACK}
    Element Should Be Visible    ${BTN_ADD_BACKPACK}

Verify Cart Badge Count
    [Arguments]    ${expected_count}
    Element Text Should Be    ${BADGE_CART}    ${expected_count}

Verify Cart Badge Is Empty
    Element Should Not Be Visible    ${BADGE_CART}

Verify Specific Product Remove Button Is Displayed
    [Arguments]    ${product_name}
    ${slug}=    Evaluate    "${product_name}".lower().replace(" ", "-")
    Element Should Be Visible    id=remove-${slug}

Get Product Details At Index
    [Arguments]    ${index}
    ${name}=    Get Text    xpath=(//div[@class='inventory_item'])[${index}]//div[@class='inventory_item_name ']
    ${price}=    Get Text    xpath=(//div[@class='inventory_item'])[${index}]//div[@class='inventory_item_price']
    RETURN    ${name}    ${price}

Click Product At Index
    [Arguments]    ${index}
    Click Element    xpath=(//div[@class='inventory_item_name '])[${index}]