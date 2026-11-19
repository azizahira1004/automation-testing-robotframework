*** Variables ***
${BACK_HOME_BTN}         id=back-to-products
${GENERATE_PDF_BTN}      id=generate-pdf-order

*** Keywords ***
Check Order Confirmation Screen
    [Arguments]    ${expected_header}=Thank you for your order!
    Wait Until Element Is Visible    ${LBL_COMPLETE}    5s
    Element Text Should Be           ${LBL_COMPLETE}    ${expected_header}
    Wait Until Element Is Visible    ${BACK_HOME_BTN}       5s
    Element Should Be Enabled        ${BACK_HOME_BTN}
    Wait Until Element Is Visible    ${GENERATE_PDF_BTN}    5s
    Element Should Be Enabled        ${GENERATE_PDF_BTN}
