*** Settings ***
Documentation     Verifies the static social media icons and legal information in the Swag Labs mobile app footer.
Resource          ../resource.robot
Suite Setup       setup.Spawn Appium Server
Test Setup        setup.Open App
Test Teardown     Close Application
Suite Teardown    teardown.Close Appium Server

*** Test Cases ***
TC01 - Verify Mobile Footer Social Icons And Legal Information
    [Documentation]    Verifies that the social media icons and legal information are visible in the mobile app footer. The native app icons are static and do not open external links.
    [Tags]    footer    smoke    social_media
    Login Mobile User And Verify Catalog    standard_user    secret_sauce
    FooterLogic.Verify Mobile Footer
