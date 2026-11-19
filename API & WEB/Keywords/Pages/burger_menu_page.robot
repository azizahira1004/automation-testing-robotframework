*** Variables ***
# Burger Menu & Sidebar Locators
${BURGER_MENU_BTN}              id=react-burger-menu-btn
${BURGER_CLOSE_BTN}             id=react-burger-cross-btn
${SIDEBAR_MENU_WRAP}            css=.bm-menu-wrap

# Standard Menu Items
${MENU_ALL_ITEMS}               id=inventory_sidebar_link
${MENU_ABOUT}                   id=about_sidebar_link
${MENU_LOGOUT}                  id=logout_sidebar_link
${MENU_RESET_APP_STATE}         id=reset_sidebar_link

# Dynamic Catalog Dropdown & Submenus
${MENU_DYNAMIC_CATALOG}         xpath=//nav[contains(@class,'bm-item-list')]//*[contains(normalize-space(.), 'Dynamic Catalog')]
${SUBMENU_LAZY_LOAD}            id=dynamic_catalog_lazy_load_link
${SUBMENU_SPINNER}              id=dynamic_catalog_spinner_link
${SUBMENU_SLIDER}               id=dynamic_catalog_slider_link

${LAZY_LOAD_CONTAINER}          css=[data-test="dynamic-catalog-lazy-load-container"]
${LAZY_LOAD_CARD}               css=[data-test="dynamic-catalog-lazy-load-container"] .dynamic_catalog_card
${LAZY_LOAD_SENTINEL}           css=[data-test="dynamic-catalog-lazy-load-sentinel"]

${SPINNER_TITLE}        css=[data-test="title"]
${SPINNER_CONTAINER}    css=[data-test="dynamic-catalog-spinner-container"]
${SPINNER_GRID}         css=[data-test="dynamic-catalog-spinner-grid"]
${SPINNER_CARD}         css=[data-test="dynamic-catalog-spinner-grid"] .dynamic_catalog_card
${LOADING_SPINNER}      css=[data-test*="spinner"]:not([data-test*="container"]):not([data-test*="grid"]):not([data-test*="item"])

${SLIDER_TITLE}         css=[data-test="title"]
${SLIDER_CONTAINER}     css=[data-test="dynamic-catalog-slider-container"]
${SLIDER_ITEM}          css=[data-test="dynamic-catalog-slider-item"]
${SLIDER_ITEM_IMG}      css=[data-test="dynamic-catalog-slider-item-img"]
${SLIDER_ITEM_NAME}     css=[data-test="dynamic-catalog-slider-item-name"]
${SLIDER_ITEM_PRICE}    css=[data-test="dynamic-catalog-slider-item-price"]
${SLIDER_DOTS}          css=[data-test="dynamic-catalog-slider-dots"] .dynamic_catalog_slider_dot

# Dynamic Catalog Content Locators
${INVENTORY_ITEM_CARD}          css=.inventory_item
${SLIDER_ACTIVE_IMAGE}          css=.slick-active img, .swiper-slide-active img, [class*='slider'] img

# Cart & Product Locators (untuk Reset App State)
${CART_BADGE}                   css=[data-test="shopping-cart-badge"]
${ADD_TO_CART_BUTTONS}          css=button[data-test^="add-to-cart-"]
${REMOVE_BUTTONS}               css=button[data-test^="remove-"]
${LOGIN_BUTTON}                 id=login-button

*** Keywords ***
Open Burger Menu
    Wait Until Element Is Visible    ${BURGER_MENU_BTN}    10s
    Click Element    ${BURGER_MENU_BTN}
    Wait Until Element Is Visible    ${MENU_LOGOUT}    10s

Open Dynamic Catalog Dropdown
    Wait Until Element Is Visible    ${MENU_DYNAMIC_CATALOG}    10s
    Click Element                    ${MENU_DYNAMIC_CATALOG}
    Wait Until Element Is Visible    ${SUBMENU_LAZY_LOAD}    10s
    Wait Until Element Is Visible    ${SUBMENU_SPINNER}      10s
    Wait Until Element Is Visible    ${SUBMENU_SLIDER}       10s

Click Reset Link
    Click Element    ${MENU_RESET_APP_STATE}
