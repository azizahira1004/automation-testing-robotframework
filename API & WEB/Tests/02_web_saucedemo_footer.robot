*** Settings ***
Resource          ${EXECDIR}/resources.txt
Test Setup        Open Homepage
Test Teardown     Capture Failed and Close All Browsers
Suite Teardown    Close All Browsers

*** Test Cases ***
TC01 - Verify Footer Social Media Links Open Correctly In New Tab
    [Documentation]    Memverifikasi semua link media sosial di footer (Twitter/X, Facebook, LinkedIn) terbuka di tab baru, mengarah ke URL SauceLabs yang sesuai, dan halaman tampil valid (tidak blank atau 404/5xx).
    [Tags]    footer    smoke    social_media
    login_logic.Login With Credentials    ${STANDARD_USER.USERNAME}    ${STANDARD_USER.PASSWORD}
    inventory_page.Verify Inventory Page Loaded
    footer_logic.Verify All Social Media Links In Footer